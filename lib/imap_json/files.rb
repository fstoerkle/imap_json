
require_relative './config.rb'

module Files
  
  

  def self.create_directories(output_directory)
    email_directory = "#{output_directory}/emails"
    raw_directory = "#{output_directory}/raw" 

    [ output_directory, email_directory, raw_directory ].each do |directory|
      create_if_not_exists directory
    end
  end

private
  def self.create_if_not_exists(directory_name)
    Dir.mkdir directory_name unless Dir.exists? directory_name
  end
end