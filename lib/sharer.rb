require "sharer/version"

require "net/https"
require 'xmlrpc/client'
require 'rexml/document'

module Sharer
  
  class Site
    
    def initialize url
      @url = url
      add_url_protocol
    end 
       
    # Find the number of likes by url
    def facebook_likes
      return nil unless valid_url?
      path = "http://api.facebook.com/method/fql.query?query=select%20%20like_count%20from%20link_stat%20where%20url=%22#{@url}%22"
      content = content(path)
      root = REXML::Document.new(content)
      root.elements[1].elements["link_stat/like_count"].text.to_i
    end
    
    # Find the number of shares
    def facebook_shares
      return nil unless valid_url?
      path = "http://graph.facebook.com/?id=#{@url}"
      content = content(path)
      content(path).match(/\"shares\":([0-9]*),/)[1].to_i
    end
    
    # Find the number of tweeter buttons by url
    def twitter_button
      return nil unless valid_url?
      path = "http://urls.api.twitter.com/1/urls/count.json?url=#{@url}"
      content(path).match(/\"count\":([0-9]*),/)[1].to_i
    end
    
    # Find the number of linkedin shares by url
    def linked_in_share
      return nil unless valid_url?
      path = "http://www.linkedin.com/countserv/count/share?url=#{@url}&callback=myCallback&format=json"
      content(path).match(/\"count\":([0-9]*),/)[1].to_i
    end
    
    # Find shareing by url
    def find_all
      return nil unless valid_url?
      
      data = {}
      threads = []

      threads << Thread.new do
        data["facebook_likes"] = facebook_likes
      end
      
      threads << Thread.new do
        data["facebook_shares"] = facebook_shares
      end

      threads << Thread.new do
        data["twitter_tweets"] = twitter_button
      end

      threads << Thread.new do
        data["linked_in_shared"] = linked_in_share
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
    
    def add_url_protocol
      unless @url[/^www./]
        @url = 'www.' + @url
      end
      unless @url[/^http:\/\//]
        @url = 'http://' + @url
      end
    end
    
  end
end
