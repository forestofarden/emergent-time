class EventComments < Application
  # provides :xml, :yaml, :js

  include Merb::RepertoireCore::ApplicationHelper

  def index(event_id)
    @event = Event.get(event_id)
    raise NotFound unless @event
        
    display @event.event_comments, :layout => false
  end
  
  def new(event_id)
    @event = Event.get(event_id)
    raise NotFound unless @event
  
    @event_comment = EventComment.new(:event => @event )
    display @event_comment, :layout => false
  end

  def validate_create_ec(event_id, event_comment)
    only_provides :json
    
    @event = Event.get(event_id)
    raise NotFound unless @event
    
    @event_comment = EventComment.new(event_comment)
    @event_comment.event = @event
    @event_comment.user = session.user
    @event_comment.user_ip  = request.remote_ip
      
    display @event_comment.valid? || @event_comment.errors_as_params
  end

  def create(event_id, event_comment)
    @event = Event.get(event_id)
    raise NotFound unless @event
    
    @event_comment = EventComment.new(event_comment)
    @event_comment.event = @event
    @event_comment.user = session.user
    @event_comment.user_ip  = request.remote_ip
    
    if @event_comment.save
      redirect resource(@event), :message => {:notice => "EventComment was successfully created"}
    else
      message[:error] = "EventComment failed to be created"
      render :index
    end
  end

end # EventComments
