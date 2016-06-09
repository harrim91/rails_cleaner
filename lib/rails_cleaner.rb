require 'rails_cleaner/version'

module RailsCleaner

  def self.hello(dog)
    puts "Hello World #{dog}!"
  end

  def self.init
    Dir.mkdir '.rails_cleaner'
    File.open '.rails_cleaner/tracked_files.txt', 'w'
  end

  def self.track path="app/assets"
    tracked_files = Dir.glob("#{path}/**/*").select do |file|
      file.match(/.(scss|coffee)$/)
    end

    File.open '.rails_cleaner/tracked_files.txt', 'w' do |file|
      tracked_files.each do |entry|
        file.write "#{entry}\n"
      end
    end
  end

  def self.sort
    File.open '.rails_cleaner/tracked_files.txt', 'r' do |tracked_files|
      tracked_files.each_line do |line|
        if File.ctime(line)==File.birthtime(line)
          File.open '.rails_cleaner/files_to_delete.txt', 'w' do |file|
            file.write "#{line}\n"
          end
        end
      end
    end
  end

end
