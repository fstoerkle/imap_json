
require 'highline/import'

module Password
  def self.get
    ask('Enter IMAP password: ') { |q| q.echo = '*' }
  end
end