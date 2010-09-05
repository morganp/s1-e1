
# Stackover flow question on Twitter OAuth
# http://stackoverflow.com/questions/2612745/oauth-gives-me-401-error/2613200#2613200
# gem install twitter
# read consumer_token.rb 
# Then run 'ruby get_keys.rb'

require 'rubygems'
require 'twitter'

#Load keys
require 'consumer_keys'
require 'access_token'

#Load rss parser
require 'rss_parse'

require 'shorturl'

# NOT SHOWN: granting access to twitter on website
# and using request token to generate access token
# This is down by reading and completing consumer_keys.rb and running get_keys.rb
oauth = Twitter::OAuth.new(cKey, cSecret)
oauth.authorize_from_access(aToken, aSecret)


client = Twitter::Base.new(oauth)
#client.friends_timeline.each  { |tweet| puts tweet.inspect }
#client.user_timeline.each     { |tweet| puts tweet.text }
#client.replies.each           { |tweet| puts tweet.inspect }
#client.update('Helloworld!')

def format_for_twitter(msg, url)
   if (msg.length + url.length + 1) > 140
      #TODO find simpe way to split message on last space before cur len
      cut_msg_len = 140 -  url.length - 4
      msg = msg[0...cut_msg_len] + "..."
   end
   return msg + " " + url
end

def get_time_run
## based on http://rubylearning.com/satishtalim/read_write_files.html
 if File.exists?('run.log') 
   File.open('run.log', 'r') do |f|  
      while line = f.gets  
         @last_run = line  
      end  
   end 
 end
 #Nice default if anything above failed
 @last_run ||= Time.at(0) 
end

def set_run_time
   if File.exists?("run.log")
      File.delete("run.log")
   end
   File.open('run.log', 'w') do |f2|  
      f2.puts Time.now  
   end  
end

# Now for some RSS stuff
rss = get_rss(options = {:source => "http://www.bbc.co.uk/news/technology/rss.xml"})
(0...rss.items.size).to_a.reverse.each do |x|
   print "title:       ", rss.items[x].title, "\n"
   print "link:        ", rss.items[x].link, "\n"
   print "description: ", rss.items[x].description, "\n"
   print "date:        ", rss.items[x].date, "\n"

   url = Shorturl.new(rss.items[x].link).get_shorturl
   
   tweet = format_for_twitter( rss.items[x].title , url)
   
   #check date and if greater than last time ran send it
   if (rss.items[x].date <=> get_time_run) == 1
      client.update(tweet)
      puts "Sent tweet: " + tweet
   end
   puts 

end
   #Set run time after itterarting all tweets so first does not block all of the following
   set_run_time

