#!/usr/bin/env ruby

require_relative 'toggl_reporter/fetcher'
require_relative 'toggl_reporter/config'
require_relative 'toggl_reporter/summary'
require 'pry'

puts 'Welcome to Toggl Reporter'

config = TogglReporter::Config.new
fetcher = TogglReporter::Fetcher.new(config)

fetcher.projects.each_with_index { |p, i| puts "#{i + 1} - #{p['name']}" }
fetcher.project_data(project_id: fetcher.projects.first['id'],
                     billable: 'false')

project_id = fetcher.projects.first['id']
summary = TogglReporter::Summary.new(fetcher: fetcher,
                                     project_id: project_id).call
