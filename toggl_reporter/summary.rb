require 'json'

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
    end

    private

    def connection_params(params)
      {
        project_ids: project_id,
        workspace_id: fetcher.workspace,
        grouping: 'users',
        billable: params[:billable]
      }
    end
  end
end
