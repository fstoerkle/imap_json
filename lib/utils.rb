
require 'highline/import'

module Utils
  def self.read_password
    ask('Enter IMAP password: ') { |q| q.echo = '*' }
  end

  def error(message)
    $stderr.puts message
  end

  def fatal(message, code=1)
    error message
    exit code
  end
end