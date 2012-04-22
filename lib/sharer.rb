require "sharer/version"

require "net/https"
require 'xmlrpc/client'
require 'rexml/document'

module Sharer
  
  class << self
    
    # Find the number of likes by url
    def facebook_likes url
      return nil unless valid_url? url 

      path = "http://api.facebook.com/method/fql.query?query=select%20%20like_count%20from%20link_stat%20where%20url=%22#{url}%22"
      content = content(path)
      root = REXML::Document.new(content)
      root.elements[1].elements["link_stat/like_count"].text.to_i
    end
    
    # Find the number of tweeter buttons by url
    def twitter_button url
      return nil unless valid_url? url
      path = "http://urls.api.twitter.com/1/urls/count.json?url=#{url}"
      content(path).match(/\"count\":([0-9]*),/)[1].to_i
    end
    
    # Find the number of linkedin shares by url
    def linked_in_share url
      return nil unless valid_url? url
      path = "http://www.linkedin.com/countserv/count/share?url=#{url}&callback=myCallback&format=json"
      content(path).match(/\"count\":([0-9]*),/)[1].to_i
    end
    
    # Find shareing by url
    def find url
      return nil unless valid_url? url
      
      data = {}
      threads = []

      threads << Thread.new do
        data["facebook"] = facebook_likes url
      end

      threads << Thread.new do
        data["google"] = self.twitter_button url
      end

      threads << Thread.new do
        data["twitter"] = self.linked_in_share url
      end

      threads.each {|t| t.join }
      data
    end
    
    
    private
    # Valid url
    def valid_url? url
      (url =~ URI::regexp).nil?
    end
    
    # Content by url
    def content url
      begin
        Net::HTTP.get_response(URI.parse(url)).body
      rescue => exception
        print exception.backtrace.join("\n")
      end
    end
    
  end
end
