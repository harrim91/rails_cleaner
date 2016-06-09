require 'rails_cleaner/version'

module RailsCleaner

  DIRECTORY_PATH = ".rails_cleaner"
  FILE_NAME = "tracked_files.txt"

  def self.hello
    puts "you are about to delete #{File.open("#{DIRECTORY_PATH+'/'+FILENAME}", "r").each { |line| puts line }}"
    puts "y or n?"
    answer = gets.chomp
    if answer.downcase == 'y'
      self.test
    end
  end

  def self.test
    puts "next level - you legend!"
  end

  def self.init
    Dir.mkdir "#{DIRECTORY_PATH}"
    File.open "#{DIRECTORY_PATH}/#{FILE_NAME}", 'w'
  end

  def self.track path="app/assets"
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


end
