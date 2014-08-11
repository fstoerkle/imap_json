
require 'net/imap'

require_relative './config.rb'
require_relative './password.rb'

class Imap
  def initialize
    @imap = Net::IMAP.new Configuration['host'], Configuration['port'], Configuration['use_ssl']
    @imap.login Configuration['username'], Password.get
  end

  def list(mailbox=nil)
    @imap.list(mailbox || '', '*')
  end
end