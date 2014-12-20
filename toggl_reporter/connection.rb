require 'faraday'
require 'logger'

module TogglReporter
  class Connection
    attr_accessor :connection

    def initialize(config)
      @connection = Faraday.new(connection_params(config)) do |f|
        f.request :url_encoded
        f.response :logger, Logger.new('faraday.log')
        f.adapter Faraday.default_adapter
        f.headers = { 'Content-Type' => 'application/json' }
        f.basic_auth config.api_token, 'api_token'
      end
    end

    private

    def connection_params(config)
      {
        url: 'https://www.toggl.com/reports/api/v2',
        ssl: { verify: false },
        params: { user_agent: config.email }
      }
    end
  end
end
