class TimelineComments < Application
  # provides :xml, :yaml, :js

  include Merb::RepertoireCore::ApplicationHelper

  def index(shortname, permalink)
    @user = User.first(:shortname => shortname)
    raise NotFound unless @user
    @timeline = @user.timelines.first(:permalink => permalink)
    raise NotFound unless @timeline
    
    display @timeline.timeline_comments, :layout => false
  end
  
  def new(shortname, permalink)
    @user = User.first(:shortname => shortname)
    raise NotFound unless @user
    @timeline = @user.timelines.first(:permalink => permalink)
    raise NotFound unless @timeline
      
    @timeline_comment = TimelineComment.new(:timeline => @timeline )
    display @timeline_comment, :layout => false
  end

  def validate_create_tc(shortname, permalink, timeline_comment)
    only_provides :json
    
    @user = User.first(:shortname => shortname)
    raise NotFound unless @user
    @timeline = @user.timelines.first(:permalink => permalink)
    raise NotFound unless @timeline
    
    @timeline_comment = TimelineComment.new(timeline_comment)
    @timeline_comment.timeline = @timeline
    @timeline_comment.user = session.user
    @timeline_comment.user_ip  = request.remote_ip
      
    display @timeline_comment.valid? || @timeline_comment.errors_as_params
  end

  def create(shortname, permalink, timeline_comment)
    @user = User.first(:shortname => shortname)
    raise NotFound unless @user
    @timeline = @user.timelines.first(:permalink => permalink)
    raise NotFound unless @timeline
    
    @timeline_comment = TimelineComment.new(timeline_comment)
    @timeline_comment.timeline = @timeline
    @timeline_comment.user = session.user
    @timeline_comment.user_ip  = request.remote_ip
    
    if @timeline_comment.save
      redirect resource(@timeline.user, @timeline), :message => {:notice => "TimelineComment was successfully created"}
    else
      message[:error] = "TimelineComment failed to be created"
      render :index
    end
  end

end # TimelineComments
