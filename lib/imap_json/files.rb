
require_relative './config.rb'

module Files
  OUTPUT_DIR  = Configuration['output_dir']
  EMAIL_DIR   = "#{OUTPUT_DIR}/emails"
  RAW_DIR     = "#{OUTPUT_DIR}/raw"

  def self.create_directories
    [ OUTPUT_DIR, EMAIL_DIR, RAW_DIR ].each { |dir| create_if_not_exists dir }
  end

private
  def self.create_if_not_exists(dir_name)
    Dir.mkdir dir_name unless Dir.exists? dir_name
  end
end