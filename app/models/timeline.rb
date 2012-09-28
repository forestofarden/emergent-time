require 'postgresql_helpers'

class Timeline < ActiveRecord::Base
  extend PostgreSQLHelpers
  
  belongs_to :user
  
  has_many :timeline_events
  has_many :events, :through => :timeline_events
  
  has_many :timeline_comments, :order => 'created_at DESC'
  
  validates_uniqueness_of :title, :scope => :user_id
  validates_uniqueness_of :permalink, :scope => :user_id
    
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
  
  def default_title(prefix)
    self.title = Timeline.default_title(prefix)
  end
  
  def recent_event
    sql = <<-SQL
      SELECT id FROM timeline_events
      WHERE timeline_id = #{self.id}
      ORDER BY coalesce(created_at, modified_at) DESC
      LIMIT 1
    SQL
    
    result = connection.select_value(sql)
    result.empty? ? nil : TimelineEvent.find(result)
  end
  
  def related(n=5, cutoff=5)
    sql = <<-SQL
    SELECT te2.timeline_id FROM timeline_events te1, timeline_events te2
    WHERE te1.timeline_id = #{id} AND te1.event_id = te2.event_id AND te1.timeline_id != te2.timeline_id
    GROUP BY te2.timeline_id HAVING count(*) >= #{cutoff} 
    ORDER BY count(*) DESC LIMIT #{n}
    SQL
    
    result = repository.adapter.query(sql)
    Timeline.all(:id => result)
  end
  
  def to_param
    permalink
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
      sql = <<-SQL
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
      
      result = connection.select_values(sql)
      Timeline.where(:id => result).all
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
