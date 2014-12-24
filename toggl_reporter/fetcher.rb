require 'faraday'
require 'logger'
require 'json'
require 'hashie'

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
      url = 'reports/api/v2/summary'
      Hashie::Mash.new(JSON.parse(connection.get(url, params).body))
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
        ssl: ssl_params(config),
        params: { user_agent: config.email }
      }
    end

    def ssl_params(config)
      return { verify: false } if config.cert_path.nil?
      { ca_file: config.cert_path }
    end
  end
end
