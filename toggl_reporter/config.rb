require 'yaml'

module TogglReporter
  class Config
    attr_accessor :api_token, :email

    def initialize
      @api_token = config['api_token']
      @email = config['email']
    end

    private

    def config
      dir_path = File.dirname(File.expand_path(__FILE__))
      YAML::load_file(File.join(dir_path, '../config.yml'))
    end
  end
end
