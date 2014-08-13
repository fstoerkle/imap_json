#!/usr/bin/env ruby


require_relative 'lib/config'
require_relative 'lib/email'
require_relative 'lib/files'
require_relative 'lib/imap'



imap = Imap.new
imap.list(Configuration['mailbox']).each do |mailbox|
  imap.mails_for(mailbox.name) do |mail|
    puts mail.subject
  end
end


# Files.create_directories