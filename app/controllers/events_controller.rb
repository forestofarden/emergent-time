class EventsController < ActionController::Base

  layout 'application'
  
  respond_to :html, :json
  
  RANK_CUTOFF = 0.85                      # don't include overview events below this rank (for very very small repositories)

  def index
    q, n = params[:q], params[:n]
    
    @event_count = Event.count
    begin
      @limit = Integer(n.to_s)
    rescue ArgumentError => e
      # in very small repositories, only show 20% of events (mostly for demoing overview timelines)
      @limit = [500, @event_count / 5].min
      @limit = [25, @limit].max
    end
    
    if q.blank?
      @timelines = Timeline.recent(7)
      @top_events = Event.where("rank > #{RANK_CUTOFF}").order('rank DESC').limit(@limit).all
    else
      # TODO.  integrate our event / timeline rank value with fulltext hit ranking
      @search_term = q
      @timelines = Timeline.search(q, :order => 'rank DESC', :limit => 20)       
      @total_timelines = Timeline.search(q).size
      @top_events = Event.search(q, :order => 'rank DESC', :limit => @limit)
      @total_events = Event.search(q).size
    end
  end
  
  def show
    @event = Event.find(params[:id])
    raise "Not Found" unless @event
    @cross_section = TimelineEvent.where(:event_id => params[:id]).all
  end
  
  def suggest
    timeline_event, event = params[:timeline_event], params[:event]
    @top_events = []
    
    if event && event[:start]
      title = event[:title]
      description = event[:description]
      begin
        # attempt to parse fields and get suggested events
        start_date = DateTime.parse(event[:start])
        end_date = event[:end].blank? ? nil : DateTime.parse(event[:end])
        @top_events = Event.suggest("#{title} #{description}", start_date, end_date)
        
        # don't suggest events already in the current timeline
        @timeline = Timeline.find(timeline_event[:timeline_id])
        if @timeline
          @top_events -= @timeline_events
          #if timeline_events = @timeline.events
          #  timeline_event_ids = timeline_events.map { |e| e.id }
          #  @top_events.delete_if { |e| timeline_event_ids.include?(e.id) }
          #end
        end
        
        # always include current event, if there is one
        cur_evt_id =  timeline_event[:event_id]
        unless cur_evt_id.empty?
          cur_evt = Event.find(cur_evt_id)
          @top_events.delete_if { |e| e.id == cur_evt_id }
          @top_events.unshift(cur_evt)
        end
        
      rescue ArgumentError => e
        # suggest nothing when given a non-parsing date
      end
    end
    
    respond_with @top_events
  end
  
end
