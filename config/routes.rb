EmergentTime::Application.routes.draw do

  path_prefix = EmergentTime::Application.config.repertoire_assets.path_prefix

  scope "(/#{path_prefix})" do

    devise_for :users
    
    resources :users do
      resources :timelines do
        get "fields", :on => :member
      end
    end
    
    resources :timelines do
      resources :events,   :controller => "timeline_events"
      resources :comments, :controller => "timeline_comments"
    end
    
    resources :events do
      resources :events, :controller => "event_comments" do
        get "validate"
      end
      collection do
        get "validate"
        get "suggest"
      end
      member do
        get "validate"
        get "timelines"
      end
    end

    resources :docs
  end
    
  root :to => "events#index"
#  match("/webservice/events/validate").to(:controller => "timeline_events", :action => "validate_create_te").name(:validate_create_te)
#  match("/webservice/events/suggest").to(:controller => "events", :action => "suggest").name(:suggest_event)
#  match("/webservice/events/:event_id/validate").to(:controller => "event_comments", :action => "validate_create_ec").name(:validate_create_ec)
    
  # TODO. not working inside resource, for some reason
#  match("/webservice/timeline_comments/:shortname/:permalink/validate").to(:controller => "timeline_comments", :action => "validate_create_tc").name(:validate_create_tc)

  # special webservice to redirect to same timeline after its permalink changes
#  match("/webservice/redirect/timelines/:id").to(:controller => "timelines", :action => :redirect_to).name(:redirect_to_timeline)
end
