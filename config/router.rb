# Merb::Router is the request routing mapper for the merb framework.
#
# You can route a specific URL to a controller / action pair:
#
#   match("/contact").
#     to(:controller => "info", :action => "contact")
#
# You can define placeholder parts of the url with the :symbol notation. These
# placeholders will be available in the params hash of your controllers. For example:
#
#   match("/books/:book_id/:action").
#     to(:controller => "books")
#   
# Or, use placeholders in the "to" results for more complicated routing, e.g.:
#
#   match("/admin/:module/:controller/:action/:id").
#     to(:controller => ":module/:controller")
#
# You can specify conditions on the placeholder by passing a hash as the second
# argument of "match"
#
#   match("/registration/:course_name", :course_name => /^[a-z]{3,5}-\d{5}$/).
#     to(:controller => "registration")
#
# You can also use regular expressions, deferred routes, and many other options.
# See merb/specs/merb/router.rb for a fairly complete usage sample.

Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  app_path_prefix = Merb::Config[:path_prefix] || ''            # slice_url does not observe app's path_prefix
  
  resources :event_comments
  slice(:merb_auth_slice_password, :name_prefix => nil, :path_prefix => app_path_prefix)
  slice(:repertoire_core, :name_prefix => nil, :path_prefix => app_path_prefix)
  
  resources :timeline_events
  resources :events do
    resources :event_comments
  end

  # TODO.  come up with routing scheme that never nests higher that 2 levels

  identify(User => :shortname, Timeline => :permalink) do
    resources :users do
      resources :timelines do
        match("/webservice/field_value/:id").to(:action => :field_value).name(:field_value)
        resources :timeline_comments
      end
    end
  end
  
  match("/webservice/events/validate").to(:controller => "timeline_events", :action => "validate_create_te").name(:validate_create_te)
  match("/webservice/events/suggest").to(:controller => "events", :action => "suggest").name(:suggest_event)
  # TODO. not working inside resource, for some reason
  match("/webservice/timeline_comments/:shortname/:permalink/validate").to(:controller => "timeline_comments", :action => "validate_create_tc").name(:validate_create_tc)
  
  match("/webservice/events/:event_id/validate").to(:controller => "event_comments", :action => "validate_create_ec").name(:validate_create_ec)
  
  # TODO.  should be REST, but... is it okay to have same data at two different REST urls?  weird
  match("/webservice/events/:event_id/timelines").to(:controller => "timeline_events", :action => "cross_section").name(:event_timelines)

  # special webservice to redirect to same timeline after its permalink changes
  match("/webservice/redirect/timelines/:id").to(:controller => "timelines", :action => :redirect_to).name(:redirect_to_timeline)

  match("/docs/:page(.:format)").to(:controller => "docs", :action => "show").name(:docs)
  
  # This is the default route for /:controller/:action/:id
  # This is fine for most cases.  If you're heavily using resource-based
  # routes, you may want to comment/remove this line to prevent
  # clients from calling your create or destroy actions with a GET
  # default_routes
  
  # Change this for your home page to be available at /
  match('/').to(:controller => 'events', :action =>'index')
end