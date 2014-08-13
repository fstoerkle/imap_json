
require 'highline/import'

module Utils
  def self.read_password
    puts
    ask(' * Please enter IMAP password: ') { |q| q.echo = '*' }
  end

  def self.console(start_message, stop_message='finished')
    print ">> #{start_message}... "
    yield
    puts stop_message
  end

  def self.error(message)
    $stderr.puts message
  end

  def self.fatal(message, code=1)
    error message
    exit code
  end
end