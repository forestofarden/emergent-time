require 'postgresql_helpers'

class Event < ActiveRecord::Base
  extend PostgreSQLHelpers
  
  belongs_to :user
  
  has_many :timeline_events
  has_many :timelines, :through => :timeline_events
  
  has_many :event_comments, :order => 'created_at DESC'
  
  validate :finish, :consistent?

  def consistent?
    if self.finish.nil? || (self.finish > self.start)
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
