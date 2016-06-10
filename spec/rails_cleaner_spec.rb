require 'spec_helper'

describe RailsCleaner do

  subject(:rails_cleaner) { described_class.new }
  let(:rc_directory) { described_class::DIRECTORY_PATH }
  let(:tracked_files_list) { described_class::TRACKED_FILES_LIST }
  let(:to_delete_list) { described_class::TO_DELETE_LIST }

  before :each do
    Dir.mkdir 'app'
    Dir.mkdir 'app/assets'
    Dir.mkdir 'app/assets/style'
    Dir.mkdir 'app/assets/javascripts'
    File.open 'app/assets/javascripts/file1.coffee', 'w'
    File.open 'app/assets/javascripts/file2.coffee', 'w'
    File.open 'app/assets/style/file1.scss', 'w'
    File.open 'app/assets/style/file2.scss', 'w'
    File.open 'app/assets/style/file1.rb', 'w'
  end

  after :each do
    FileUtils.rm_r '.rails_cleaner'
    FileUtils.rm_r 'app'
  end

  describe '#create_rc_directory' do
    it 'creates a .rails_cleaner directory' do
      rails_cleaner.create_rc_directory
      expect(File.exist? rc_directory).to eq true
    end
  end

  describe '#create_rc_file' do
    it 'creates a file in the .rails_cleaner directory' do
      rails_cleaner.create_rc_directory
      rails_cleaner.create_rc_file tracked_files_list
      expect(File.exist? rc_directory + tracked_files_list).to eq true
    end
  end

  describe '#set_tracked_files' do
    before :each do
      rails_cleaner.create_rc_directory
      rails_cleaner.create_rc_file tracked_files_list
    end

    it 'sets all the scss and coffee files in app/assets' do
      rails_cleaner.set_tracked_files
      expect(rails_cleaner.tracked_files.sort).to eq [
                                          'app/assets/javascripts/file1.coffee',
                                          'app/assets/javascripts/file2.coffee',
                                          'app/assets/style/file1.scss',
                                          'app/assets/style/file2.scss']
    end
  end

  describe '#write_data_to_file' do
    before :each do
      rails_cleaner.create_rc_directory
      rails_cleaner.create_rc_file tracked_files_list
    end
    it 'writes data from an array to a file in the rc_directory' do
      names = ['michael', 'elia', 'jack', 'joe']
      rails_cleaner.write_data_to_file names, tracked_files_list
      names.each do |name|
        expect(File.read(rc_directory+tracked_files_list)).to match name
      end
    end
  end

  describe '#set_files_to_delete' do
    before :each do
      rails_cleaner.create_rc_directory
      rails_cleaner.create_rc_file tracked_files_list
      rails_cleaner.set_tracked_files
      rails_cleaner.write_data_to_file rails_cleaner.tracked_files, tracked_files_list
      sleep 1
      File.open 'app/assets/style/file1.scss', 'w' do |file|
        file.write 'modified'
      end
    end

    it 'sets all of the unmodified tracked files from the given source file' do
      rails_cleaner.set_files_to_delete tracked_files_list
      expect(rails_cleaner.files_to_delete.sort).to eq [
                                          'app/assets/javascripts/file1.coffee',
                                          'app/assets/javascripts/file2.coffee',
                                          'app/assets/style/file2.scss']
    end
  end

  describe '#remove_to_delete_list' do
    it 'deletes the delete file' do
      rails_cleaner.create_rc_directory
      rails_cleaner.create_rc_file to_delete_list
      rails_cleaner.remove_to_delete_list
      expect(File.exist? rc_directory + to_delete_list).to eq false
    end
  end

  describe '#clear_tracked_files_list' do
    it 'clears the tracking file' do
      rails_cleaner.create_rc_directory
      rails_cleaner.create_rc_file tracked_files_list
      rails_cleaner.set_tracked_files
      rails_cleaner.write_data_to_file rails_cleaner.tracked_files, tracked_files_list
      rails_cleaner.clear_tracked_files_list
      expect(File.read rc_directory + tracked_files_list).to eq ''
    end
  end

end
