class TimelineCommentsController < ActionController::Base

  def index
    @user = User.where(:shortname => params[:shortname]).first
    raise "Not Found" unless @user
    @timeline = @user.timelines.where(:permalink => params[:permalink]).first
    raise "Not Found" unless @timeline
    
    display @timeline.timeline_comments, :layout => false
  end
  
  def new
    @user = User.where(:shortname => params[:shortname]).first
    raise "Not Found" unless @user
    @timeline = @user.timelines.where(:permalink => params[:permalink]).first
    raise "Not Found" unless @timeline
      
    @timeline_comment = TimelineComment.new(:timeline => @timeline )
    display @timeline_comment, :layout => false
  end

  def validate
    only_provides :json
    
    @user = User.where(:shortname => params[:shortname]).first
    raise "Not Found" unless @user
    @timeline = @user.timelines.where(:permalink => params[:permalink]).first
    raise "Not Found" unless @timeline
    
    @timeline_comment = TimelineComment.new(params[:timeline_comment])
    @timeline_comment.timeline = @timeline
    @timeline_comment.user = current_user
    @timeline_comment.user_ip  = request.remote_ip
      
    display @timeline_comment.valid? || @timeline_comment.errors_as_params
  end

  def create
    @user = User.where(:shortname => params[:shortname]).first
    raise "Not Found" unless @user
    @timeline = @user.timelines.where(:permalink => params[:permalink]).first
    raise "Not Found" unless @timeline
    
    @timeline_comment = TimelineComment.new(params[:timeline_comment])
    @timeline_comment.timeline = @timeline
    @timeline_comment.user = current_user
    @timeline_comment.user_ip  = request.remote_ip
    
    if @timeline_comment.save
      redirect_to resource(@timeline.user, @timeline), :message => {:notice => "TimelineComment was successfully created"}
    else
      flash[:error] = "TimelineComment failed to be created"
      render :index
    end
  end

end # TimelineComments
