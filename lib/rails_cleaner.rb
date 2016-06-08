require 'rails_cleaner/version'

module RailsCleaner

  def self.init
    Dir.mkdir '.rails_cleaner'
    File.open '.rails_cleaner/tracked_files.txt', 'w'
  end

  def self.track path
    File.open '.rails_cleaner/tracked_files.txt', 'w' do |file|
      Dir.entries(path).each do |entry|
        file.write "#{path}/#{entry}\n" if entry.match(/.(scss|coffee)/)
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
