require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/docs" do
  before(:each) do
    @response = request("/docs")
  end
end