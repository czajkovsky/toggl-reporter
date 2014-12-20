require 'faraday'
require 'logger'
require 'json'

module TogglReporter
  class Fetcher
    attr_accessor :connection, :workspace, :projects

    def initialize(config)
      @connection = Faraday.new(connection_params(config)) do |f|
        f.request :url_encoded
        f.response :logger, Logger.new('faraday.log')
        f.adapter Faraday.default_adapter
        f.headers = { 'Content-Type' => 'application/json' }
        f.basic_auth config.api_token, 'api_token'
      end
      fetch_workspace
      fetch_projects
    end

    def project_data(params)
      params = {
        project_ids: params[:project_id],
        workspace_id: workspace,
        grouping: 'users',
        billable: params[:billable]
      }
      url = 'reports/api/v2/summary'
      JSON.parse(connection.get(url, params).body)
    end

    private

    def fetch_workspace
      response = JSON.parse(connection.get('api/v8/workspaces').body)
      self.workspace = response.first['id']
    end

    def fetch_projects
      url = "api/v8/workspaces/#{workspace}/projects"
      self.projects = JSON.parse(connection.get(url).body)
    end

    def connection_params(config)
      {
        url: 'https://www.toggl.com',
        ssl: { verify: false },
        params: { user_agent: config.email }
      }
    end
  end
end
