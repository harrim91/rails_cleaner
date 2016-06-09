require 'rails_cleaner/version'

module RailsCleaner

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
    unmodified_files = []

    File.open '.rails_cleaner/tracked_files.txt', 'r' do |file|
      file.each_line do |line|
        unmodified_files << line if File.ctime(line.strip)==File.birthtime(line.strip)
      end
    end

    File.open '.rails_cleaner/files_to_delete.txt', 'w' do |file|
      unmodified_files.each do |unmodified_file|
        file.write "#{unmodified_file}"
      end
    end
  end

  def self.delete
    File.open '.rails_cleaner/files_to_delete.txt', 'r' do |file|
      file.each_line do |line|
        File.delete line.strip
      end
    end
  end

end
