require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a timeline exists" do
  Timeline.all.destroy!
  request(resource(:timelines), :method => "POST", 
    :params => { :timeline => { :id => nil }})
end

describe "resource(:timelines)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:timelines))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of timelines" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a timeline exists" do
    before(:each) do
      @response = request(resource(:timelines))
    end
    
    it "has a list of timelines" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Timeline.all.destroy!
      @response = request(resource(:timelines), :method => "POST", 
        :params => { :timeline => { :id => nil }})
    end
    
    it "redirects to resource(:timelines)" do
      @response.should redirect_to(resource(Timeline.first), :message => {:notice => "timeline was successfully created"})
    end
    
  end
end

describe "resource(@timeline)" do 
  describe "a successful DELETE", :given => "a timeline exists" do
     before(:each) do
       @response = request(resource(Timeline.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:timelines))
     end

   end
end

describe "resource(:timelines, :new)" do
  before(:each) do
    @response = request(resource(:timelines, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@timeline, :edit)", :given => "a timeline exists" do
  before(:each) do
    @response = request(resource(Timeline.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@timeline)", :given => "a timeline exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Timeline.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @timeline = Timeline.first
      @response = request(resource(@timeline), :method => "PUT", 
        :params => { :timeline => {:id => @timeline.id} })
    end
  
    it "redirect to the timeline show action" do
      @response.should redirect_to(resource(@timeline))
    end
  end
  
end

