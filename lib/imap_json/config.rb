
require 'yajl'

module Configuration
  CONFIG_FILE = File.new('./imap_json.config.json', 'r')
  
  @@config = nil

  def self.config
    @@config = Yajl::Parser.parse CONFIG_FILE if @@config.nil?
  end
end
