#!/usr/bin/env ruby

require_relative 'toggl_reporter/fetcher'
require_relative 'toggl_reporter/config'
require 'pry'

puts 'Welcome to Toggl Reporter'

config = TogglReporter::Config.new
connection = TogglReporter::Fetcher.new(config)
