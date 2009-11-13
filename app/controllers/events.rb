class Events < Application

  include Merb::RepertoireCore::ApplicationHelper
  
  RANK_CUTOFF = 0.85                      # don't include overview events below this rank (for very very small repositories)

  def index(q=nil, n=nil)
    provides :json, :html
    
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
      @top_events = Event.all(:order => [:rank.desc], :limit => @limit, :rank.gt => RANK_CUTOFF)
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
    
    @cross_section = TimelineEvent.all(:event_id => id)
    
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
        
        # always include current event, if there is one
        cur_evt_id =  timeline_event[:event_id]
        unless cur_evt_id.empty?
          cur_evt = Event.get(cur_evt_id)
          @top_events.delete_if { |e| e.id == cur_evt_id }
          @top_events.unshift(cur_evt)
          puts "PUT IN THE TOP EVENT"
        else
          puts "DIDN'T PUT IT IN"
        end
        
      rescue ArgumentError => e
        # suggest nothing when given a non-parsing date
      end
    end
    render
  end
  
end
