class TimelineEvents < Application

  include Merb::RepertoireCore::ApplicationHelper

  def cross_section(event_id)
    # TODO.  should this be necessary to order on an associated column???  argh DM
    # @timeline_events = TimelineEvent.all(:event_id => event_id, :order => [DataMapper::Query::Direction.new(Timeline.properties[:rank])])
    
    @timeline_events = TimelineEvent.all(:event_id => event_id)
    render :layout => false
  end

  def new(timeline_id)
    only_provides :html
    
    @timeline = Timeline.get(timeline_id)
    raise NotFound unless @timeline

    @timeline_event = TimelineEvent.new(:timeline => @timeline, :event => Event.new)
    
    display @timeline_event, :template => 'timeline_events/edit', :layout => false
  end

  def edit(id)
    only_provides :html
    
    @timeline_event = TimelineEvent.get(id)
    raise NotFound unless @timeline_event
    
    display @timeline_event, :layout => false
  end
  
  # User validation web service for edit and signup forms
  def validate_create_te(timeline_event, event = nil)
    only_provides :json
  
    @event = Event.new(event)
    @event.user  = session.user
    @event.title = nil if @event.title.blank?
    @event.end   = nil if @event.end.blank?
    # ignore timeline_event since its fields are optional now
  
    display @event.valid? || @event.errors_as_params
  end

  # create a new timeline event association, with options to create the event 
  #   and first source comment from scratch
  #
  # N.B. handles both create and update calls
  #
  #  TODO.  should be checking if save succeeds
  def create(timeline_event, event = nil, event_comment = nil)
    @timeline_event = TimelineEvent.get(timeline_event[:id]) || TimelineEvent.new(timeline_event)
    @event          = Event.get(timeline_event[:event_id])
    
    if @event.nil?
      # create event
      @event = Event.new(event)
      @event.user  = session.user
      @event.title = nil if @event.title.blank?           # fix optional fields
      @event.end   = nil if @event.end.blank?
      @event.save || raise("Could not save event #{@event}")
            
            # # create source comment (if exists)... should have more explicit 
            # if event_comment && !event_comment[:text].empty?
            #   @event_comment = EventComment.new(event_comment)
            #   @event_comment.event = @event
            #   @event_comment.user = session.user
            #   @event_comment.user_ip  = request.remote_ip
            #   @event_comment.save       # validation required 
            # end
    end  
      
    # tie timeline entry to event
    @timeline_event.id = nil if @timeline_event.id.blank?
    @timeline_event.event = @event    
    @timeline_event.interpretation = timeline_event[:interpretation]
  
  if @timeline_event.id.nil?
    puts "ITS A BOY" 
  else
    puts "ITS A SECONDHAND GIRL"
  end
    
    @timeline_event.save || raise("Could not save #{@timeline_event}: #{@timeline_event.errors.join(', ')}")
    
    @timeline = @timeline_event.timeline
    redirect resource(@timeline.user, @timeline, :cue => @event.id), :message => { :notice => 'Updated your event entry' }
  end

  def destroy(id)
    @timeline_event = TimelineEvent.get(id)
    raise NotFound unless @timeline_event
    if @timeline_event.destroy
      redirect resource(:timeline_events)
    else
      raise InternalServerError
    end
  end

end # TimelineEvents
