
require 'yajl'

module Configuration
  @@configuration_file = './config.json'

  @@config = nil

  def self.[](key)
    if @@config.nil?
      @@config = Yajl::Parser.parse File.new(@@configuration_file, 'r')
    end

    @@config[key]
  end
end
