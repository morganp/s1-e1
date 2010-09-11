#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../lib/app'

# Currently just creating the object will run it once
# Add to cron job to run every 15 minutes
TechNews::Core.new


