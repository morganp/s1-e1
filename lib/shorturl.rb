require 'net/http'

require 'rubygems'
require 'json'
require 'cgi'

begin 
   require File.dirname(__FILE__) + '/bit_ly_key'
rescue LoadError
 STDERR.puts "You need to create a file called bit_ly_key.rb. See bit_ly_key.rb.example"
 exit
end



# JSON request and ruby
# https://www.socialtext.net/open/index.cgi?very_simple_rest_in_ruby_part_3_post_to_create_a_new_workspace
module TechNews
   class Shorturl
      def initialize( url=nil )
         bit_ly_keys = TechNews::BitLyKey.new

         ##  url encode
         url ||= "http://amaras-tech.co.uk"
         @long_url = CGI.escape( url )

         ## Inputs
         #format (optional)
         #longUrl
         #x_login (optional)
         #x_apiKey (optional)
         #
         ## Outputs
         #
         #new_hash
         #url
         #hash
         #global_hash
         #long_url
         #

         payload = "http://api.bit.ly/v3/shorten?login=#{bit_ly_keys.login}&apiKey=#{bit_ly_keys.apiKey}&longUrl=#{@long_url}&format=json"

         @response = Net::HTTP.get URI.parse(payload)
         @response = JSON.parse( @response )
      end

      def get_shorturl
         return @response["data"]["url"]
      end

   end
end

if $0 == __FILE__

   x = TechNews::Shorturl.new()
   puts x.get_shorturl

end
