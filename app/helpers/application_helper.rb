module ApplicationHelper
  
  # @return a url to identify the given user's profile photo
  def gravatar_image_url(email, size=40)
    default_gravatar_uri = request.protocol + "://#{request_host}#{path_prefix}/images/gravatar.png"
    return default_gravatar_uri if email.nil?

    email_md5 = Digest::MD5.hexdigest(email)
    encoded_uri = URI.escape(default_gravatar_uri, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    "http://www.gravatar.com/avatar.php?gravatar_id=#{email_md5}&default=#{encoded_uri}&size=#{size}" 
  end
  
  def path_prefix
    EmergentTime::Application.config.repertoire_assets.path_prefix
  end
  
  def request_host
    request.host.force_encoding('utf-8')
  end

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
    html << tag(:div, flash[:error], :class => 'error') if flash[:error]
    if obj
      obj.errors.each do |err|
        html << tag(:div, err.to_s, :class => 'error')
      end
    end
    html << tag(:div, flash[:notice], :class => 'notice') if flash[:notice]
    tag :div, html.join, :class => 'messages'
  end

  def textilize(*s)
    RedCloth.new(s.join).to_html
  end

end