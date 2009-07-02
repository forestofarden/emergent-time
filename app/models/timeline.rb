class Timeline
  include DataMapper::Resource
  
  extend Hypertime::Utilities
  
  property :id, Serial
  
  property :title, String, :size => 250, :nullable => false
  property :intro, Text
  
  property :permalink, String, :nullable => false
  
  property :links, Integer
  property :rank, Float, :precision => 15       # without precision, dm validations always reject
  
  belongs_to :user
  
  property :created_at, DateTime
  property :modified_at, DateTime
  
  has n, :timeline_events
  has n, :events, :through => :timeline_events
  
  has n, :timeline_comments, :order => [:created_at.desc]
  
  validates_is_unique :title, :scope => :user_id
  validates_is_unique :permalink, :scope => :user_id
    
  def destroy
    success = false
    transaction do
      success = timeline_events.destroy! && super
    end
    success
  end
  
  def title=(new_title)
    self.permalink = new_title.to_permalink
    attribute_set(:title, new_title)
  end
  
  def default_title!(prefix)
    self.title = Timeline.default_title(prefix)
  end
  
  def recent_event
    sql = <<-SQL.compress_lines
      SELECT id FROM timeline_events
      WHERE timeline_id = #{self.id}
      ORDER BY coalesce(created_at, modified_at) DESC
      LIMIT 1
    SQL
    
    result = repository.adapter.query(sql)
    result.empty? ? nil : TimelineEvent.get(result)
  end
  
  def related(n=5, cutoff=5)
    sql = <<-SQL.compress_lines
    SELECT te2.timeline_id FROM timeline_events te1, timeline_events te2
    WHERE te1.timeline_id = #{id} AND te1.event_id = te2.event_id AND te1.timeline_id != te2.timeline_id
    GROUP BY te2.timeline_id HAVING count(*) > #{cutoff} 
    ORDER BY count(*) DESC LIMIT #{n}
    SQL
    
    result = repository.adapter.query(sql)
    Timeline.all(:id => result)
  end
  
  class << self
    
    def search(q, opts={})
      q = sanitize_tsquery(q)
      Timeline.all(opts.merge(:conditions => ["_fulltext @@ to_tsquery(?)", q]))
    end
    
    # return n timelines with most recent event additions, max 1 per user
    def recent(n=5)
      # rather nasty sql since we can't use max() in having clause with postgres
      # so we run the query twice to find five most recent users and join to get
      # the respective timelines that contained those events
      sql = <<-SQL.compress_lines
      SELECT timeline_id FROM
        (SELECT user_id, max(coalesce(timeline_events.modified_at, timeline_events.created_at)) AS date 
          FROM timeline_events JOIN timelines ON (timeline_id = timelines.id)
          GROUP BY user_id
          ORDER BY date DESC LIMIT #{n}) AS recent_by_user,
        (SELECT timeline_id, user_id, max(coalesce(timeline_events.modified_at, timeline_events.created_at)) AS date 
          FROM timeline_events JOIN timelines ON (timeline_id = timelines.id)
          GROUP BY timeline_id, user_id) AS recent_by_timeline
        WHERE recent_by_user.user_id = recent_by_timeline.user_id AND recent_by_user.date = recent_by_timeline.date;
      SQL
      
      result = repository(:default).adapter.query(sql)
      Timeline.all(:id => result)
    end
    
    # updates with a unique generated title based on the prefix
    def default_title(prefix)
      suffix = 1
      while first(:title => "#{prefix} #{suffix}") do
         suffix += 1
      end
      "#{prefix} #{suffix}"
    end
  end
end
