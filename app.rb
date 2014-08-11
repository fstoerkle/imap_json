#!/usr/bin/env ruby

require_relative 'lib/email.rb'
require_relative 'lib/files.rb'
require_relative 'lib/imap.rb'

imap = Imap.new
imap.list(Configuration['mailbox']).each do |mailbox|
  imap.messages_for(mailbox.name) do |message|
    puts message
    exit
  end
  exit
end



# Files.create_directories