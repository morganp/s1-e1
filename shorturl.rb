require 'net/http'

require 'rubygems'
require 'json'
require 'cgi'

# Register at [1] and get api key [2]
# [1]: http://bit.ly
# [2]: http://bit.ly/a/your_api_key

# JSON request and ruby
# https://www.socialtext.net/open/index.cgi?very_simple_rest_in_ruby_part_3_post_to_create_a_new_workspace
class Shorturl
   def initialize( url=nil )
      @login="munkymorgy"
      @apiKey="R_a9030d4c0963a7486c44f551fad26575"

      ##  url encode
      # require 'uri'
      # long_url = URI.escape("http://amaras-tech.co.uk", Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
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

      payload = "http://api.bit.ly/v3/shorten?login=#{@login}&apiKey=#{@apiKey}&longUrl=#{@long_url}&format=json"

      response = Net::HTTP.get URI.parse(payload)

      #response = "{ \"status_code\": 200, \"status_txt\": \"OK\", \"data\": { \"long_url\": \"http:\\/\\/amaras-tech.co.uk\", \"url\": \"http:\\/\\/bit.ly\\/9WwtNh\", \"hash\": \"9WwtNh\", \"global_hash\": \"9gcSEQ\", \"new_hash\": 0 } }\n"

      #Nasty Formatting, to get json to s ruby Symbol
      # Find nicer way to do this.
      response.gsub!(/\{(.*)\}/, '\1')
      ## Ruby 1.8.x does not have regex lookbehinds 
      #  response.gsub!(/(?!http):/,'=>')
      response.gsub!(/:/,'=>')
      response.gsub!('http=>','http:')
      #wanted this to be non-greedy, but would have matched the first and last \" over the entire string
      response.gsub!(/\"([-_a-zA-Z]*)\"(?==>)/, ':\1')
      response["\n"] = ''
      #response = response.split(',')
      eval("@response = { #{response} }")

      #return response[:data][:url] 
   end

   def get_shorturl
      return @response[:data][:url]
   end

end


if $0 == __FILE__

   x = Shorturl.new()
   puts x
   puts x.get_shorturl

end
