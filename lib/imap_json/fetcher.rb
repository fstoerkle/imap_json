
require 'imap_json/files'
require 'imap_json/imap'
require 'imap_json/utils'

class Fetcher
  def initialize(config)
    @config = config

    Files.set_output_directory @config['output_dir']

    Utils.console 
    Utils.console('Creating output directories') do 
      Files.create_directories
    end

    @imap = Imap.new @config

    @imap.list(@config['mailbox']).each do |mailbox|
      @imap.mails_for(mailbox.name) do |email|
        Files.save_json email.uid, email.to_json
        exit
      end
    end 
  end
end