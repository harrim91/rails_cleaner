require 'rails_cleaner/version'
require 'colorize'

module RailsCleaner

  DIRECTORY_PATH = '.rails_cleaner'
  TRACKED_FILE_NAME = 'tracked_files.txt'
  DELETE_FILE_NAME = 'files_to_delete.txt'

  def self.init
    Dir.mkdir DIRECTORY_PATH unless Dir.exist?(DIRECTORY_PATH)
    File.open "#{DIRECTORY_PATH}/#{TRACKED_FILE_NAME}", 'w' unless File.exist?("#{DIRECTORY_PATH}/#{TRACKED_FILE_NAME}",)
  end

  def self.track path='app/assets'
    tracked_files = Dir.glob("#{path}/**/*").select do |file|
      file.match(/.(scss|coffee)$/)
    end

    File.open "#{DIRECTORY_PATH}/#{TRACKED_FILE_NAME}", 'w' do |file|
      tracked_files.each do |entry|
        file.write "#{entry}\n"
      end
    end
  end

  def self.sort
    unmodified_files = []

    File.open "#{DIRECTORY_PATH}/#{TRACKED_FILE_NAME}", 'r' do |file|
      file.each_line do |line|
        unmodified_files << line if File.ctime(line.strip)==File.birthtime(line.strip)
      end
    end

    File.open "#{DIRECTORY_PATH}/#{DELETE_FILE_NAME}", 'w' do |file|
      unmodified_files.each do |unmodified_file|
        file.write "#{unmodified_file}"
      end
    end
  end

  def self.delete
    files = []

    File.open "#{DIRECTORY_PATH}/#{DELETE_FILE_NAME}", 'r' do |file|
      file.each_line do |line|
        files << line.strip
      end
    end

    self.confirm_delete files

    files.each do |file|
      File.delete file
    end

    self.delete_delete_file
    self.clear_tracking_file

  end

  private
  def self.confirm_delete files
    if files.empty?
      puts 'no files to delete'
      exit
    end
    puts 'you are about to delete:'
    files.each { |file| puts file.colorize(:red) }
    puts 'y or n?'
    answer = gets.chomp
    fail 'delete aborted' unless answer.downcase == 'y'
  end

  def self.delete_delete_file
    File.delete "#{DIRECTORY_PATH}/#{DELETE_FILE_NAME}"
  end

  def self.clear_tracking_file
    File.open "#{DIRECTORY_PATH}/#{TRACKED_FILE_NAME}", 'w' do |file|
      file.truncate 0
    end
  end

end
