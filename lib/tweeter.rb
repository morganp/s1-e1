require 'rubygems'
require 'twitter'

#Load keys
require  File.dirname(__FILE__) + '/consumer_keys'
require  File.dirname(__FILE__) + '/access_token'

module TechNews
   class Tweeter

      attr_reader :last_tweet

      def initialize
         # NOT SHOWN: granting access to twitter on website
         # and using request token to generate access token
         # This is down by reading and completing consumer_keys.rb and running get_keys.rb
         
         oauth  = Twitter::OAuth.new(cKey, cSecret)
         oauth.authorize_from_access(aToken, aSecret)
         
         @client = Twitter::Base.new(oauth)
      end

      def update( msg )
         @last_tweet = format_for_twitter(msg, '' )
         @client.update( tweet )
      end

      def update_with_url( msg, url )
         @last_tweet = format_for_twitter(msg, url )
         #@client.update( @last_tweet )
      end

      private

      def format_for_twitter(msg, url)
         if (msg.length + url.length + 1) > 140
            #TODO find simpe way to split message on last space before cur len
            cut_msg_len = 140 -  url.length - 4
            msg = msg[0...cut_msg_len] + "..."
         end
         return msg + " " + url
      end


      # TODO sections to implement
      #client.friends_timeline.each  { |tweet| puts tweet.inspect }
      #client.user_timeline.each     { |tweet| puts tweet.text }
      #client.replies.each           { |tweet| puts tweet.inspect }

   end
end
