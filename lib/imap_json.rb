
require 'imap_json/config'
require 'imap_json/email'
require 'imap_json/files'
require 'imap_json/imap'

module ImapJson
  def self.run
    imap = Imap.new
    imap.list(Configuration['mailbox']).each do |mailbox|
      imap.mails_for(mailbox.name) do |mail|
        puts mail.subject
      end
    end

    # Files.create_directories
  end
end