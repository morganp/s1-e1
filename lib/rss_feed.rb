## RSS parsing from http://rubyrss.com//

require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

module TechNews
   class RssFeed
      
      attr_reader :rss
      attr_reader :rss_feed_sort_date
      
      def initialize( options={} )
         options[:source] ||= "http://www.bbc.co.uk/news/technology/rss.xml" # url or local file
         content = "" # raw content of rss feed will be loaded here

         begin
            open(options[:source]) do |s| content = s.read end
            @rss = RSS::Parser.parse(content, false)
            @rss_feed_sort_date = @rss.items.sort_by { |item| item.date }
         rescue OpenURI::HTTPError => error
            puts "Bad URL #{options[:source]}"
            puts error
            exit
         end
      end

   end
end

#When Calling file directly do something to demo functionality
if __FILE__ == $0
   ## Use rss
   @rss_feed  = TechNews::RssFeed.new
   #rss = get_rss()
   puts "Root values"
   print "RSS title: ",             @rss_feed.rss.channel.title, "\n"
   print "RSS link: ",              @rss_feed.rss.channel.link, "\n"
   print "RSS description: ",       @rss_feed.rss.channel.description, "\n"
   print "RSS publication date: ",  @rss_feed.rss.channel.date, "\n"

   puts "Item values"
   print "number of items: ",     @rss_feed.rss.items.size, "\n"
   print "title of first item: ", @rss_feed.rss.items[0].title, "\n"
   print "link of first item: ",  @rss_feed.rss.items[0].link, "\n"
   print "description of first item: ", @rss_feed.rss.items[0].description, "\n"
   print "date of first item: ",  @rss_feed.rss.items[0].date, "\n"

end
