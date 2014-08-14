
require 'yajl'

module Files
  @@directories = Hash.new
  
  def self.setup(output_directory)
    @@directories[:output] = File.expand_path output_directory
    @@directories[:json] = File.join output_directory, 'json'
    @@directories[:raw] = File.join output_directory, 'raw'

    @@directories.values.each { |d| create_dir d }
  end

  def self.save_json(dir_name, email)
    path = build_path(create_sub_dir(:json, dir_name), email.uid, 'json')
    File.open(path, 'w') do |file|
      Yajl::Encoder.encode(email.to_hash, file, :pretty => true)
    end
  end

  def self.save(dir_name, email)
    path = build_path(create_sub_dir(:raw, dir_name), email.uid, 'txt')
    File.write(path, email.to_s)
  end

  def self.save_attachement(dir_name, email, filename, contents)
    path = build_path(create_sub_dir(:json, "#{dir_name}.#{email.uid}"), filename)
    File.write(path, contents)
  end

private
  def self.create_dir(directory_path)
    Dir.mkdir directory_path unless Dir.exists? directory_path

    directory_path
  end

  def self.create_sub_dir(parent_name, sub_dir)
    path = @@directories[parent_name.to_sym]

    sub_dir.split('.').each do |dir|
      path = File.join path, dir
      create_dir path
    end

    path
  end

  def self.build_path(directory_path, filename, extension=nil)
    filename = "#{filename}.#{extension}" unless extension.nil?
    
    File.join directory_path, filename
  end
end