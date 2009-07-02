class Timelines < Application
  # provides :xml, :yaml, :js

  include Merb::RepertoireCore::ApplicationHelper

  def index(shortname)
    @user = User.first(:shortname => shortname)
    raise NotFound unless @user
    @timelines = @user.timelines
    
    @new_timeline = Timeline.new
    @new_timeline.default_title!('New Timeline')
    
    display @timelines
  end

  def show(shortname, permalink, cue = nil)
    provides :html, :json
    
    @user = User.first(:shortname => shortname)
    raise NotFound unless @user

    @timeline  = @user.timelines.first(:permalink => permalink)
    raise NotFound unless @timeline
    @cue_event = @timeline.events.first(:id => cue) if cue
    
    display @timeline
  end

  def create(shortname, timeline)
    @user = User.first(:shortname => shortname)
    raise NotFound unless @user

    @timeline = Timeline.new(timeline)
    @timeline.user = @user;
    
    if @timeline.save
      redirect resource(@user, @timeline), :message => {:notice => "Timeline was successfully created"}
    else
      message[:error] = "Timeline could not be created"
      
      @timeline.errors.each { |ter| puts ter }
      
      render :index
    end
  end
  
  # following methods are webservices for inline editing of textile fields
  def field_value(shortname, permalink, id, textilize=false)
    provides :text
    @user = User.first(:shortname => shortname)
    raise NotFound unless @user
    @timeline = @user.timelines.first(:permalink => permalink)
    raise NotFound unless @timeline
    
    value = @timeline.send(id)
    value = textilize(value) if textilize
    
    value
  end

  def update(shortname, permalink, timeline, id=nil)
    provides :html, :text
    
    @user = User.first(:shortname => shortname)
    raise NotFound unless @user
    @timeline = @user.timelines.first(:permalink => permalink)
    raise NotFound unless @timeline
    
    unless @timeline.update_attributes(timeline)
      @timeline.errors.each { |e| puts e }
      raise "Error while updating"
    end
    
    if id.blank?
      @timeline.reload     # in case save failed, return old value
      redirect resource(@user, @timeline)
    else
      # TODO.  intro is actually only field that's textilized... how to get around
      #        loop back from update function?  jeditable requires moving view code into controller
      value = @timeline.send(id)
      if id == 'intro'
        render textilize(value)
      else
        render value
      end
    end
  end

  def destroy(shortname, permalink)
    @user = User.first(:shortname => shortname)
    raise NotFound unless @user
    @timeline = @user.timelines.first(:permalink => permalink)
    raise NotFound unless @timeline

    if @timeline.destroy
      redirect resource(@user, :timelines)
    else
      raise InternalServerError
    end
  end

  # given a timeline's database id, redirect to the shortname/permalink url (for re-titling timelines)
  def redirect_to(id)
    @timeline = Timeline.get(id)
    raise NotFound unless @timeline
    
    redirect resource(@timeline.user, @timeline)
  end

end # Timelines
