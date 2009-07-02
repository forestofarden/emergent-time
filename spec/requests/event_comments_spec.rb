require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a event_comment exists" do
  EventComment.all.destroy!
  request(resource(:event_comments), :method => "POST", 
    :params => { :event_comment => { :id => nil }})
end

describe "resource(:event_comments)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:event_comments))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of event_comments" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a event_comment exists" do
    before(:each) do
      @response = request(resource(:event_comments))
    end
    
    it "has a list of event_comments" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      EventComment.all.destroy!
      @response = request(resource(:event_comments), :method => "POST", 
        :params => { :event_comment => { :id => nil }})
    end
    
    it "redirects to resource(:event_comments)" do
      @response.should redirect_to(resource(EventComment.first), :message => {:notice => "event_comment was successfully created"})
    end
    
  end
end

describe "resource(@event_comment)" do 
  describe "a successful DELETE", :given => "a event_comment exists" do
     before(:each) do
       @response = request(resource(EventComment.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:event_comments))
     end

   end
end

describe "resource(:event_comments, :new)" do
  before(:each) do
    @response = request(resource(:event_comments, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@event_comment, :edit)", :given => "a event_comment exists" do
  before(:each) do
    @response = request(resource(EventComment.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@event_comment)", :given => "a event_comment exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(EventComment.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @event_comment = EventComment.first
      @response = request(resource(@event_comment), :method => "PUT", 
        :params => { :event_comment => {:id => @event_comment.id} })
    end
  
    it "redirect to the event_comment show action" do
      @response.should redirect_to(resource(@event_comment))
    end
  end
  
end

