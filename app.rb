
# Stackover flow question on this
# http://stackoverflow.com/questions/2612745/oauth-gives-me-401-error/2613200#2613200
# gem install twitter
# read consumer_token.rb 
# Then run 'ruby get_keys.rb'

require 'rubygems'
require 'twitter'

#Load keys
require 'consumer_keys'
require 'access_token'

# NOT SHOWN: granting access to twitter on website
# and using request token to generate access token
# This is down by reading and completing consumer_keys.rb and running get_keys.rb
oauth = Twitter::OAuth.new(cKey, cSecret)
oauth.authorize_from_access(aToken, aSecret)


client = Twitter::Base.new(oauth)
#client.friends_timeline.each  { |tweet| puts tweet.inspect }
#client.user_timeline.each     { |tweet| puts tweet.text }
#client.replies.each           { |tweet| puts tweet.inspect }
client.update('Helloworld!')

# Now for some RSS stuff


