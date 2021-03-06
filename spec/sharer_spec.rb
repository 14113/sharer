require 'spec_helper'

describe Sharer do

  before(:all) do
      @site = Sharer::Site.new("google.com")
  end

  it "find count of likes on facebook" do
      @site.facebook_likes.should be_a(Integer)
       @site.facebook_likes.should > 0
    end

    it "find count of likes on twitter" do
      @site.twitter_button.should be_a(Integer)
      @site.twitter_button.should > 0
    end

    it "find count of likes on twitter" do
      @site.linked_in_share.should be_a(Integer)
      @site.linked_in_share.should > 0
    end

    it "find count of shareing on facebook" do
      @site.facebook_shares.should be_a(Integer)
      @site.facebook_shares.should > 0
    end

    it "find count of shareing in facebook, twitter and linkedin" do
      @site.find_all.should be_a(Hash)
    end

    it "find count of likes on facebook by invalid url" do
      @site = Sharer::Site.new("ada:example/com")
      @site.facebook_likes.should eq(0)
    end

end