class TimelineEvent < ActiveRecord::Base

  belongs_to :timeline
  belongs_to :event
  
  def <=>(other)
    event.start <=> other.event.start
  end
    
end
