require 'dm-ar-finders'
require 'dm-timestamps'

class Event
  include DataMapper::Resource
  
  extend Hypertime::Utilities
  
  property :id, Serial
  
  # size limits are intentional - event descriptions are limited to discourage
  #   extensive interpretation (see timeline_event.interpretation)
  property :title, String, :length => 100
  property :description, String, :nullable => false, :length => (15..250)

  property :start, DateTime, :nullable => false
  property :end,   DateTime
  
  property :links, Integer
  property :rank, Float, :auto_validation => false       # without, dm validations reject as wrong precision
  
  property :created_at, DateTime
  property :modified_at, DateTime
  
  belongs_to :user
  
  has n, :timeline_events
  has n, :timelines, :through => :timeline_events
  
  has n, :event_comments, :order => [:created_at.desc]
  
  validates_with_method :end, :method => :consistent?

  def consistent?
    if self.end.nil? || (self.end > self.start)
      true
    else
      [false, 'End should be after start.']
    end
  end
  
  def <=>(other)
    start <=> other.start
  end

  class << self
    def search(q, opts={})
      q = sanitize_tsquery(q)
      Event.all(opts.merge(:conditions => ["_fulltext @@ to_tsquery(?)", q]))
    end
    
    def suggest(q, start_date, end_date, n=20)
      q = sanitize_tsquery(q)
      
      # TODO. balance ranking of events with distance from search start date
      # TODO. this is open to sql injection attacks
      props = [ :id, :title, :description, :start, :end, :rank, :created_at, :modified_at, :user_id ]
      props = props.map { |p| self.properties[p] }
      sql = ""
      sql << "SELECT id, title, description, start, \"end\", rank, created_at, modified_at, user_id FROM EVENTS "
      sql << "WHERE _fulltext @@ to_tsquery('#{q}') " unless q.empty?
      sql << "ORDER BY distance(start, \"end\", '#{start_date}'::TIMESTAMP, '#{end_date || start_date}'::TIMESTAMP) ASC " unless start_date.blank?
      sql << "LIMIT #{n} "      
      Event.find_by_sql(sql, :properties => props)
    end
  end 
end
