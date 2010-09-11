require 'fileutils'

module TechNews
   class TimeStamp

      def initialize
         @run_time_file = File.dirname(__FILE__) + '/../logs/run.time'
      end

      def get_time
      ## based on http://rubylearning.com/satishtalim/read_write_files.html
       
       if File.exists?( @run_time_file ) 
         File.open(@run_time_file , 'r') do |f|  
            while line = f.gets  
               @last_run = Time.at(line.to_i)
            end  
         end 
       end
       #Nice default if anything above failed
       @last_run ||= Time.at(0) 
      end

      def set_time
         if not File.directory?( File.dirname(__FILE__) + '/../logs' )
            FileUtils.makedirs( File.dirname(__FILE__) + '/../logs' )
         end

         if File.exists?( @run_time_file )
            File.delete( @run_time_file )
         end
         File.open( @run_time_file, 'w') do |f2|  
            f2.puts Time.now.to_i  
         end  
      end
   end
end
