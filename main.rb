#!/usr/bin/env ruby

require 'net/imap'
require 'highline/import'

config = {
  :mailbox  => 'Archive',
  :host     => 'leo.uberspace.de',
  :port     => 993,
  :use_ssl  => true,
  :username => 'stoerkle'
}

class Imap
  def initialize(config)
    @config = config
    @imap = Net::IMAP.new(config[:host], config[:port], config[:use_ssl])
    @imap.login(config[:username], read_password)
  end

  def list(mailbox=nil)
    @imap.list(mailbox || '', '*')
  end

private
  def read_password
    ask('Enter IMAP password: ') { |q| q.echo = '*' }
  end
end

imap = Imap.new config
imap.list(config[:mailbox]).each { |mailbox| puts mailbox.name }
