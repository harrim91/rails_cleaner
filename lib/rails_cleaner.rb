require 'rails_cleaner/version'
require 'colorize'
require 'byebug'

class RailsCleaner

  DIRECTORY_PATH = '.rails_cleaner/'
  TRACKED_FILES_LIST = 'tracked_files.txt'
  TO_DELETE_LIST = 'files_to_delete.txt'
  ASSETS_PATH = 'app/assets'

  attr_reader :tracked_files, :files_to_delete

  def create_rc_directory
    Dir.mkdir DIRECTORY_PATH unless File.exist? DIRECTORY_PATH
  end

  def create_rc_file filename
    File.open DIRECTORY_PATH + filename, 'w'
  end

  def set_tracked_files
    @tracked_files = Dir.glob("#{ASSETS_PATH}/**/*").select do |file|
      file.match(/.(scss|coffee)$/)
    end
  end

  def set_files_to_delete file_path
    @files_to_delete = []
    File.open DIRECTORY_PATH + file_path, 'r' do |file|
      file.each_line do |line|
        @files_to_delete << line.strip if File.ctime(line.strip)==File.birthtime(line.strip)
      end
    end
  end

  def write_data_to_file data, file
    File.open DIRECTORY_PATH + file, 'w' do |f|
      data.each do |d|
        f.write "#{d}\n"
      end
    end
  end

  def delete_delete_file
    File.delete DIRECTORY_PATH + TO_DELETE_LIST if File.exist? DIRECTORY_PATH + TO_DELETE_LIST
  end

  def clear_tracking_file
    if File.exist? DIRECTORY_PATH + TRACKED_FILES_LIST
      File.open DIRECTORY_PATH + TRACKED_FILES_LIST, 'w' do |file|
        file.truncate 0
      end
    end
  end

end
