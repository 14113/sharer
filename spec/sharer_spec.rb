require 'spec_helper'

describe Sharer do
  it "find count of likes on facebook" do
      Sharer.facebook_likes("google.com").should be_a(Integer)
    end
    
    it "find count of likes on twitter" do
      Sharer.twitter_button("google.com").should be_a(Integer)
    end

    it "find count of likes on twitter" do
      Sharer.linked_in_share("google.com").should be_a(Integer)
    end
    
    it "find count of shareing in facebook,twitter and linkedin" do
      Sharer.find("google.com").should be_a(Hash)
    end
    
    it "find count of likes on facebook by invalid url" do
      Sharer.facebook_likes("ada:example/com").should eq(nil)
    end
    
end