
require 'highline/import'

module Utils
  def self.read_password
    puts
    ask(' * Please enter IMAP password: ') { |q| q.echo = '*' }
  end

  def self.console(start_message='', stop_message='finished')
    if block_given?
      print ">> #{start_message}... "
      yield
      puts stop_message
    else
      puts start_message
    end
  end

  def self.error(message)
    puts
    $stderr.puts " ! [Error] #{message}"
  end

  def self.fatal(message, code=1)
    error message
    exit code
  end
end