#!/usr/bin/env ruby

require_relative 'lib/imap.rb'

imap = Imap.new
imap.list(Configuration['mailbox']).each { |mailbox| puts mailbox.name }
