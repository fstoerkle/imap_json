
require 'imap_json/config'
require 'imap_json/fetcher.rb'

module ImapJson
  def self.run
    Fetcher.new Configuration.config
  end
end