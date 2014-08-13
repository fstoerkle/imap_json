
require 'imap_json/config'
require 'imap_json/files'
require 'imap_json/imap'
require 'imap_json/utils.rb'

module ImapJson
  @@imap = nil

  def self.setup
    puts
    
    Utils.console('Creating output directories') { Files.create_directories }

    @@imap = Imap.new
  end

  def self.run
    self.setup

    @@imap.list(Configuration['mailbox']).each do |mailbox|
      @@imap.mails_for(mailbox.name) do |mail|
        puts mail.subject
      end
    end 
  end
end