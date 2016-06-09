require 'rails_cleaner/version'

module RailsCleaner

  def self.init
    Dir.mkdir '.rails_cleaner'
    File.open '.rails_cleaner/tracked_files.txt', 'w'
  end

  def self.track path
    tracked_files = Dir.glob("#{path}/**/*").select do |file|
      file.match(/.(scss|coffee)$/)
    end

    File.open '.rails_cleaner/tracked_files.txt', 'w' do |file|
      tracked_files.each do |entry|
        file.write "#{path}/#{entry}\n"
      end
    end
  end

  def self.sort(from,to)
    new_array = []
      File.foreach(from) do |line|
      file = line.strip.gsub(''', ')
        if File.ctime(file)==File.birthtime(file)
          new_array << file
        end
      File.open to, 'w' do |f|
        new_array.each do |line|
          f.write line + '\n'
        end
      end
    end
  end
end
