require 'rails_cleaner/version'

module RailsCleaner

  DIRECTORY_PATH = ".rails_cleaner"
  FILE_NAME = "tracked_files.txt"

  def self.test
    puts "next level - you legend!"
  end

  def self.init
    Dir.mkdir DIRECTORY_PATH unless Dir.exist?(DIRECTORY_PATH)
    File.open "#{DIRECTORY_PATH}/#{FILE_NAME}", 'w' unless File.exist?("#{DIRECTORY_PATH}/#{FILE_NAME}",)
  end

  def self.track path='app/assets'
    tracked_files = Dir.glob("#{path}/**/*").select do |file|
      file.match(/.(scss|coffee)$/)
    end

    File.open "#{DIRECTORY_PATH}/#{FILE_NAME}", 'w' do |file|
      tracked_files.each do |entry|
        file.write "#{entry}\n"
      end
    end
  end

  def self.sort
    unmodified_files = []

    File.open "#{DIRECTORY_PATH}/#{FILE_NAME}", 'r' do |file|
      file.each_line do |line|
        unmodified_files << line if File.ctime(line.strip)==File.birthtime(line.strip)
      end
    end

    File.open "#{DIRECTORY_PATH}/files_to_delete.txt", 'w' do |file|
      unmodified_files.each do |unmodified_file|
        file.write "#{unmodified_file}"
      end
    end
  end

  def self.delete
    self.confirm_delete
    File.open '.rails_cleaner/files_to_delete.txt', 'r' do |file|
      file.each_line do |line|
        File.delete line.strip
      end
    end
  end

  private
  def self.confirm_delete
    puts 'you are about to delete:'
    File.open "#{DIRECTORY_PATH+'/'+FILE_NAME}", 'r' do |file|
      file.each_line { |line| puts line }
    end
    puts 'y or n?'
    answer = gets.chomp
    fail 'delete aborted' unless answer.downcase == 'y'
  end
end
