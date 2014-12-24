require 'yaml'

module TogglReporter
  class Config
    attr_accessor :api_token, :email, :cert_path

    def initialize
      @api_token = config['api_token']
      @email = config['email']
      @cert_path = config['cert_path']
    end

    private

    def config
      dir_path = File.dirname(File.expand_path(__FILE__))
      YAML::load_file(File.join(dir_path, '../config.yml'))
    end
  end
end
