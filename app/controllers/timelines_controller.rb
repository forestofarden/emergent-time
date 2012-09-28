class TimelinesController < ActionController::Base

  def index
    @user = User.where(:shortname => params[:shortname]).first
    raise "Not Found" unless @user
    @timelines = @user.timelines
    
    @new_timeline = Timeline.new
    @new_timeline.default_title('New Timeline')
    
    display @timelines
  end

  def show
    provides :html, :json
    cue = params[:cue]
    
    @user = User.where(:shortname => params[:shortname]).first
    raise "Not Found" unless @user

    @timeline  = @user.timelines.where(:permalink => params[:permalink]).first
    raise "Not Found" unless @timeline
    @cue_event = @timeline.events.where(:id => cue).first if cue
    
    display @timeline
  end

  def create
    @user = User.where(:shortname => params[:shortname]).first
    raise "Not Found" unless @user

    @timeline = Timeline.new(params[timeline])
    @timeline.user = @user;
    
    if @timeline.save
      redirect_to resource(@user, @timeline), :message => {:notice => "Timeline was successfully created"}
    else
      flash[:error] = "Timeline could not be created"
      @timeline.errors.each { |ter| Rails.logger.error ter }
      
      render :index
    end
  end
  
  # following method is webservice for inline editing of textile fields
  def field_value
    provides :text
    @user = User.where(:shortname => params[shortname]).first
    raise "Not Found" unless @user
    @timeline = @user.timelines.where(:permalink => params[:permalink]).first
    raise "Not Found" unless @timeline
    
    value = @timeline.send(params[:id])              # TODO.  close security hole by checking attr_accessible
    value = textilize(value) if params[:textilize]
    
    render value
  end

  def update
    provides :html, :text
    
    @user = User.where(:shortname => params[:shortname]).first
    raise "Not Found" unless @user
    @timeline = @user.timelines.where(:permalink => params[:permalink]).first
    raise "Not Found" unless @timeline
    
    unless @timeline.update_attributes(params[:timeline])
      @timeline.errors.each { |e| Merb.logger.error e }
      raise "Error while updating"
    end
    
    if params[:id].blank?
      @timeline.reload     # in case save failed, return old value
      redirect_to resource(@user, @timeline)
    else
      # TODO.  intro is actually only field that's textilized... how to get around
      #        loop back from update function?  jeditable requires moving view code into controller
      value = @timeline.send(params[:id])
      if params[:id] == 'intro'
        render textilize(value)
      else
        render value
      end
    end
  end

  def destroy
    @user = User.where(:shortname => params[:shortname]).first
    raise "Not Found" unless @user
    @timeline = @user.timelines.where(:permalink => params[:permalink]).first
    raise "Not Found" unless @timeline

    if @timeline.destroy
      redirect_to resource(@user, :timelines)
    else
      raise InternalServerError
    end
  end

  # given a timeline's database id, redirect to the shortname/permalink url (for re-titling timelines)
  def redirect_to
    @timeline = Timeline.find(params[:id])
    raise "Not Found" unless @timeline
    
    redirect_to resource(@timeline.user, @timeline)
  end

end # Timelines
