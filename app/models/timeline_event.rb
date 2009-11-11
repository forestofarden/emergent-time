require 'dm-timestamps'

class TimelineEvent
  include DataMapper::Resource
  
  property :id, Serial

  # interprets event in context of this timeline
  property :interpretation, Text
  
  property :created_at, DateTime
  property :modified_at, DateTime

  belongs_to :timeline
  belongs_to :event
  
  def <=>(other)
    event <=> other.event
  end
    
end
