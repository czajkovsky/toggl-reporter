module TogglReporter
  class Summary
    attr_accessor :data, :project_id, :fetcher

    def initialize(params)
      @project_id = params[:project_id]
      @fetcher = params[:fetcher]
      @data = {}
    end

    def call
      [[:billable, true], [:nonbillable, false]].each do |label, value|
        data[label] = fetcher.project_data(connection_params(billable: value))
      end
      self
    end

    def print
      print_group(data[:billable], 'billable')
      print_group(data[:nonbillable], 'non-billable')
    end

    private

    def print_group(group, label)
      puts "\nTotal #{label} - #{format_time(group.total_grand)}"
      puts '--------------'
      puts('No entries') && return if group.data.empty?
      group.data.each { |entry| puts format_user_entry(entry) }
    end

    def format_user_entry(entry)
      "#{format_time(entry.time)} - #{entry.title.user}"
    end

    def format_time(time)
      return '0h 0min' if time.nil?
      s, _ = time.divmod(1000)
      m, _ = s.divmod(60)
      h, m = m.divmod(60)
      "#{h}h #{m}min"
    end

    def connection_params(params)
      {
        project_ids: project_id,
        workspace_id: fetcher.workspace,
        grouping: 'users',
        billable: params[:billable],
        until: Time.now.strftime('%F'),
        since: (Time.now - 4 * 7 * 24 * 60 * 60).strftime('%F')
      }
    end
  end
end
