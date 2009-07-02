require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a timeline_event exists" do
  TimelineEvent.all.destroy!
  request(resource(:timeline_events), :method => "POST", 
    :params => { :timeline_event => { :id => nil }})
end

describe "resource(:timeline_events)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:timeline_events))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of timeline_events" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a timeline_event exists" do
    before(:each) do
      @response = request(resource(:timeline_events))
    end
    
    it "has a list of timeline_events" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      TimelineEvent.all.destroy!
      @response = request(resource(:timeline_events), :method => "POST", 
        :params => { :timeline_event => { :id => nil }})
    end
    
    it "redirects to resource(:timeline_events)" do
      @response.should redirect_to(resource(TimelineEvent.first), :message => {:notice => "timeline_event was successfully created"})
    end
    
  end
end

describe "resource(@timeline_event)" do 
  describe "a successful DELETE", :given => "a timeline_event exists" do
     before(:each) do
       @response = request(resource(TimelineEvent.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:timeline_events))
     end

   end
end

describe "resource(:timeline_events, :new)" do
  before(:each) do
    @response = request(resource(:timeline_events, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@timeline_event, :edit)", :given => "a timeline_event exists" do
  before(:each) do
    @response = request(resource(TimelineEvent.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@timeline_event)", :given => "a timeline_event exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(TimelineEvent.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @timeline_event = TimelineEvent.first
      @response = request(resource(@timeline_event), :method => "PUT", 
        :params => { :timeline_event => {:id => @timeline_event.id} })
    end
  
    it "redirect to the timeline_event show action" do
      @response.should redirect_to(resource(@timeline_event))
    end
  end
  
end

