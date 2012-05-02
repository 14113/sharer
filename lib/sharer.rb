require "sharer/version"

require "net/https"
require 'xmlrpc/client'
require 'rexml/document'

# == Sharer module is gem that detects the number of sharing sites
#
# A minimal implementation could be:
#   site = Sharer::Site.new("google.com")
#   @result = site.find_all
#
# This also provides the methods
# like +facebook_likes+ or +twitter_shares+
# and another...
module Sharer
  
  class Site
    
    def initialize url
      @url = url
      add_url_protocol
    end 
       
    # Find the number of facebook likes
    def facebook_likes
      return nil unless valid_url?
      path = "http://api.facebook.com/method/fql.query?query=select%20%20like_count%20from%20link_stat%20where%20url=%22#{@url}%22"
      content = content(path)
      root = REXML::Document.new(content)
      root.elements[1].elements["link_stat/like_count"].text.to_i
    end
    
    # Find the number of facebook shares
    def facebook_shares
      return nil unless valid_url?
      path = "http://graph.facebook.com/?id=#{@url}"
      content = content(path)
      content(path).match(/\"shares\":([0-9]*),/)[1].to_i
    end
    
    # Find the number of tweeter buttons
    def twitter_button
      return nil unless valid_url?
      path = "http://urls.api.twitter.com/1/urls/count.json?url=#{@url}"
      content(path).match(/\"count\":([0-9]*),/)[1].to_i
    end
    
    # Find the number of linkedin shares
    def linked_in_share
      return nil unless valid_url?
      path = "http://www.linkedin.com/countserv/count/share?url=#{@url}&callback=myCallback&format=json"
      content(path).match(/\"count\":([0-9]*),/)[1].to_i
    end
    
    # Find the number of diggs
    def diggs
      return nil unless valid_url?
      url = @url.gsub("http://www.","")
      path = "http://widgets.digg.com/buttons/count?url=#{url}"
      content(path).match(/\"diggs\": ([0-9]*),/)[1].to_i
    end
    
    # Returns the hash with all sites.
    # Method using threads 
    def find_all
      return nil unless valid_url?
      
      data = {}
      threads = []
      #TODO: use object!
      [:facebook_likes,:facebook_shares,:twitter_button,:linked_in_share,:diggs].each do |method|
        threads << Thread.new do
          data[method] = send(method)
        end
      end

      threads.each {|t| t.join }
      data
    end
    
    
    private
    # Valid url
    def valid_url?
      # TODO: Validation url
      #(@url =~ URI::regexp).nil?
      true
    end
    
    # Content by url
    def content path
      begin
        Net::HTTP.get_response(URI.parse(path)).body
      rescue => exception
        print exception.backtrace.join("\n")
      end
    end
    
    # Edit url
    def add_url_protocol
      #TODO: use better regex
      unless @url[/^www./]
        @url = 'www.' + @url
      end
      unless @url[/^http:\/\//]
        @url = 'http://' + @url
      end
    end
    
  end
end
