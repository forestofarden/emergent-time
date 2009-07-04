class Events < Application

  include Merb::RepertoireCore::ApplicationHelper

  def index(q=nil, n=250)
    provides :json, :html
    @limit = Integer(n.to_s)
    if q.blank?
      @timelines = Timeline.recent(7)
      @top_events = Event.all(:order => [:rank.desc], :limit => @limit)
    else
      # TODO.  integrate our event / timeline rank value with fulltext hit ranking
      @search_term = q
      @timelines = Timeline.search(q, :order => [:rank.desc], :limit => 20)       
      @total_timelines = Timeline.search(q).size
      @top_events = Event.search(q, :order => [:rank.desc], :limit => @limit)
      @total_events = Event.search(q).size
    end
    
    render
  end
  
  def show(id)
    @event = Event.get(id)
    raise NotFound unless @event
    
    @event_comment = EventComment.new(:event => @event )
    
    display @event, :layout => false
  end
    
  
  def suggest(timeline_event, event = nil)
    provides :json
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
        @timeline = Timeline.get(timeline_event[:timeline_id])
        if @timeline
          # TODO.  why is DM's identity map not working? should be  @top_events -= @timeline.events?
          # TODO.  surely there's a way to get around this mumbo-jumbo.... 
          if timeline_events = @timeline.events
            timeline_event_ids = timeline_events.map { |e| e.id }
            @top_events.delete_if { |e| timeline_event_ids.include?(e.id) }
          end
          puts "pruned to #{@top_events.size}"
        end
        
      rescue ArgumentError => e
        # suggest nothing when given a non-parsing date
      end
    end
    render
  end
  
end
