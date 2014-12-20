#!/usr/bin/env ruby

require_relative 'toggl_reporter/fetcher'
require_relative 'toggl_reporter/config'
require 'pry'

puts 'Welcome to Toggl Reporter'

config = TogglReporter::Config.new
fetcher = TogglReporter::Fetcher.new(config)

fetcher.projects.each_with_index { |p, i| puts "#{i + 1} - #{p['name']}" }
