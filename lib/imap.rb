
require 'net/imap'

require_relative './config.rb'
require_relative './password.rb'

class Imap
  def initialize
    @imap = Net::IMAP.new Configuration['host'], Configuration['port'], Configuration['use_ssl']
    begin
      @imap.login Configuration['username'], Password.get
    rescue Net::IMAP::NoResponseError => error
      $stderr.puts "IMAP: #{error.message}"
      exit 1
    end
  end

  def list(mailbox=nil)
    @imap.list(mailbox || '', '*')
  end

  def messages_for(mailbox)
    @imap.examine mailbox
    @imap.uid_search('ALL').each do |uid|
      yield @imap.uid_fetch(uid,'RFC822').first.attr['RFC822']
    end
  end
end