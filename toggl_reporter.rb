#!/usr/bin/env ruby

require_relative 'toggl_reporter/fetcher'
require_relative 'toggl_reporter/config'
require_relative 'toggl_reporter/summary'

config = TogglReporter::Config.new
fetcher = TogglReporter::Fetcher.new(config)

fetcher.projects.each_with_index { |p, i| puts "#{i + 1} - #{p['name']}" }

puts 'Select project (type id):'
option_id = gets.chomp
selected_project = fetcher.projects[option_id.to_i - 1]

summary = TogglReporter::Summary.new(fetcher: fetcher,
                                     project_id: selected_project['id']).call
puts "\n\nReport for #{selected_project['name']} (last 4 weeks)"
summary.print
