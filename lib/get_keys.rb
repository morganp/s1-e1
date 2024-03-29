require 'rubygems'
require 'twitter'

#Load keys
require 'consumer_keys'

#Best Example
# http://oauth.rubyforge.org/rdoc/classes/OAuth/Consumer.html

consumer = OAuth::Consumer.new(
  cKey,
  cSecret,
  {:site => 'http://twitter.com'}
)

request_token = consumer.get_request_token
puts "These credentials are valid for 1 API call"
puts "Request Token  : " + request_token.token
puts "Request Secret : " + request_token.secret
puts "Request URL    : " + request_token.authorize_url

#Pin will be returned
print "> what was the PIN twitter provided you with? "
pin = (gets.chomp).to_i
puts  "\"" + pin.to_s + "\""

access_token = request_token.get_access_token(:oauth_verifier => pin)

puts "Access Token  : " + access_token.token
puts "Access Secret : " + access_token.secret

if File.exists?("access_token.rb")
   File.delete("access_token.rb")
end

# Create a new file and write to it  
File.open('access_token.rb', 'w') do |file|  
   file.puts "#Get Use a one-off request token, +pin from verifiaction URL to generate these"
   file.puts "#This file was autogenerated by get_keys.rb"
   file.puts " \n # Access Token"
   file.puts "def aToken "
   file.puts "   '#{access_token.token}' "
   file.puts "end"
   file.puts "\n"
   file.puts "# Access Secret"
   file.puts "def aSecret"
   file.puts "   '#{access_token.secret}' "
   file.puts "end"
end

