
require 'imap_json/files'
require 'imap_json/imap'
require 'imap_json/utils'

class Fetcher
  def initialize(config)
    @config = config

    Utils.console 
    Utils.console('Creating output directories') do 
      Files.create_directories @config['output_dir']
    end

    @imap = Imap.new @config

    @imap.list(@config['mailbox']).each do |mailbox|
      @imap.mails_for(mailbox.name) do |mail|
        puts mail.subject
      end
    end 
  end
end