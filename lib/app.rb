
# Stackover flow question on Twitter OAuth
# http://stackoverflow.com/questions/2612745/oauth-gives-me-401-error/2613200#2613200
# gem install twitter
# read consumer_token.rb 
# Then run 'ruby get_keys.rb'

require 'rubygems'
require File.dirname(__FILE__) + '/tweeter'

#Load rss parser
require  File.dirname(__FILE__) + '/rss_feed'
require  File.dirname(__FILE__) + '/time_stamp'

#Load ShortURL class
require  File.dirname(__FILE__) + '/shorturl'

module TechNews
   class Core
      def initialize
         ####################################################################
         @tweeter    =  TechNews::Tweeter.new
         ####################################################################
         @time_stamp =  TechNews::TimeStamp.new
         ####################################################################
         # Now for some RSS stuff
         @rss        = TechNews::RssFeed.new(
               options = {
                  :source => "http://www.bbc.co.uk/news/technology/rss.xml"
               })
         ####################################################################
         
         @rss.rss_feed_sort_date.each do |item|
            
            #check date and if greater than last time ran send it
            if (item.date <=> @time_stamp.get_time) == 1
               url   = Shorturl.new( item.link).get_shorturl

               @tweeter.update_with_url(  item.title, url )
               
               puts "Title:       " + item.title.to_s
               puts "Link:        " + item.link.to_s
               puts "Description: " + item.description.to_s
               puts "Date:        " + item.date.to_s
               puts "Sent tweet:  " + @tweeter.last_tweet
               puts 
            end

         end
         #Set run time after itterarting all tweets so first does not block the following
         @time_stamp.set_time

      end #initialize   
   end
end

if $0 == __FILE__
   x = TechNews::Core.new
end

