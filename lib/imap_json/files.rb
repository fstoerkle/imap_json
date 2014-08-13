
require_relative './config.rb'

module Files
  @@directories = Hash.new
  
  def self.set_output_directory(output_directory)
    @@directories[:output] = output_directory
    @@directories[:email] = "#{output_directory}/emails"
    @@directories[:raw] = "#{output_directory}/raw" 
  end

  def self.create_directories
    @@directories.values.each do |directory|
      create_if_not_exists directory
    end
  end

  def self.save_json(uid, json)
    path = File.join(@@directories[:email], "#{uid}.json")
    File.write(path, json)
  end

  def self.save_raw(raw_mail)

  end

private
  def self.create_if_not_exists(directory_name)
    Dir.mkdir directory_name unless Dir.exists? directory_name
  end
end