
require 'imap_json/files'
require 'imap_json/imap'
require 'imap_json/utils'

class Fetcher
  def initialize(config)
    @config = config

    Utils.console 
    Utils.console('Creating output directories') do 
      Files.setup @config['output_dir']
    end

    Utils.console('Connecting to IMAP server') do
      @imap = Imap.new @config
    end

    fetch!
  end

  def fetch!
    @imap.list(@config['mailbox']).each do |mailbox|
      @imap.mails_for(mailbox.name) do |email|
        email.save!
      end
    end 
  end
end