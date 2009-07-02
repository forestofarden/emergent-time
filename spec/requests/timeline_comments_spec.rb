require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a timeline_comment exists" do
  TimelineComment.all.destroy!
  request(resource(:timeline_comments), :method => "POST", 
    :params => { :timeline_comment => { :id => nil }})
end

describe "resource(:timeline_comments)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:timeline_comments))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of timeline_comments" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a timeline_comment exists" do
    before(:each) do
      @response = request(resource(:timeline_comments))
    end
    
    it "has a list of timeline_comments" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      TimelineComment.all.destroy!
      @response = request(resource(:timeline_comments), :method => "POST", 
        :params => { :timeline_comment => { :id => nil }})
    end
    
    it "redirects to resource(:timeline_comments)" do
      @response.should redirect_to(resource(TimelineComment.first), :message => {:notice => "timeline_comment was successfully created"})
    end
    
  end
end

describe "resource(@timeline_comment)" do 
  describe "a successful DELETE", :given => "a timeline_comment exists" do
     before(:each) do
       @response = request(resource(TimelineComment.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:timeline_comments))
     end

   end
end

describe "resource(:timeline_comments, :new)" do
  before(:each) do
    @response = request(resource(:timeline_comments, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@timeline_comment, :edit)", :given => "a timeline_comment exists" do
  before(:each) do
    @response = request(resource(TimelineComment.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@timeline_comment)", :given => "a timeline_comment exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(TimelineComment.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @timeline_comment = TimelineComment.first
      @response = request(resource(@timeline_comment), :method => "PUT", 
        :params => { :timeline_comment => {:id => @timeline_comment.id} })
    end
  
    it "redirect to the timeline_comment show action" do
      @response.should redirect_to(resource(@timeline_comment))
    end
  end
  
end

