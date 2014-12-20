require 'faraday'
require 'logger'
require 'json'

module TogglReporter
  class Fetcher
    attr_accessor :connection, :workspace

    def initialize(config)
      @connection = Faraday.new(connection_params(config)) do |f|
        f.request :url_encoded
        f.response :logger, Logger.new('faraday.log')
        f.adapter Faraday.default_adapter
        f.headers = { 'Content-Type' => 'application/json' }
        f.basic_auth config.api_token, 'api_token'
      end
      fetch_workspace
    end

    def fetch_workspace
      response = JSON.parse(connection.get('api/v8/workspaces').body)
      self.workspace = response.first['id']
    end

    private

    def connection_params(config)
      {
        url: 'https://www.toggl.com',
        ssl: { verify: false },
        params: { user_agent: config.email }
      }
    end
  end
end
