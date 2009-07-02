module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  

    include Merb::Slices::Support

    # locate a reasonable date show first
    def best_cue(cue_event, timeline=nil)
      if cue_event
        cue_event.start
      elsif timeline && (te = timeline.recent_event)
        te.event.start
      else
        Time.now()
      end
    end

    def messages(obj = nil)
      html = []
      html << tag(:div, message[:error], :class => 'error') if message[:error]
      if obj
        obj.errors.each do |err|
          html << tag(:div, err.to_s, :class => 'error')
        end
      end
      html << tag(:div, message[:notice], :class => 'notice') if message[:notice]
      tag :div, html.join, :class => 'messages'
    end

    # produce e.g. 'One hippo', '23 hippos', 'No hippos'
    def numerize(count, word)
      case count
      when 0: "No #{word.pluralize}"
      when 1: "One #{word}"
      else "#{count} #{word.pluralize}"
      end
    end
  
    def textilize(*s)
      RedCloth.new(s.join).to_html
    end
  end
end
