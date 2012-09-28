class EventCommentsController < ActionController::Base

  def index
    @event = Event.find(params[:event_id])
    raise "Not Found" unless @event
        
    display @event.event_comments, :layout => false
  end
  
  def new
    @event = Event.find(params[:event_id])
    raise "Not Found" unless @event
  
    @event_comment = EventComment.new(:event => @event )
    display @event_comment, :layout => false
  end

  def validate_event_comment
    only_provides :json
    
    @event = Event.find(params[:event_id])
    raise "Not Found" unless @event
    
    @event_comment = EventComment.new(params[:event_comment])
    @event_comment.event = @event
    @event_comment.user = current_user
    @event_comment.user_ip  = request.remote_ip
      
    display @event_comment.valid? || @event_comment.errors_as_params
  end

  def create
    @event = Event.find(params[:event_id])
    raise "Not Found" unless @event
    
    @event_comment = EventComment.new(params[:event_comment])
    @event_comment.event = @event
    @event_comment.user = current_user
    @event_comment.user_ip  = request.remote_ip
    
    if @event_comment.save
      redirect_to @event, :message => {:notice => "EventComment was successfully created"}
    else
      flash[:error] = "EventComment failed to be created"
      render :index
    end
  end

end # EventComments
