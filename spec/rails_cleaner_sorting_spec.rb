require 'spec_helper'
require 'fileutils'

describe RailsCleaner do

  subject(:rails_cleaner) { described_class }

  before :each do
    Dir.mkdir 'test_dir'
    File.open 'test_dir/file_1.coffee', 'w'
    File.open 'test_dir/file_2.scss', 'w'
  end

  after :each do
    FileUtils.rm_r '.rails_cleaner/'
    FileUtils.rm_r 'test_dir'
  end

  describe 'self#init' do
    it 'creates .rails_cleaner/tracked_files.txt' do
      rails_cleaner.init
      expect(File.exist? '.rails_cleaner/tracked_files.txt').to eq true
    end
  end

  describe 'self#track' do

    it 'adds all .coffee files in a given path to tracked_files.txt' do
      rails_cleaner.init
      rails_cleaner.track 'test_dir'
      expect(File.read '.rails_cleaner/tracked_files.txt').to match /test_dir\/file_1.coffee/
    end

    it 'adds all .sass files in a given path to tracked_files.txt' do
      rails_cleaner.init
      rails_cleaner.track 'test_dir'
      expect(File.read '.rails_cleaner/tracked_files.txt').to match /test_dir\/file_2.scss/
    end
  end

  # describe 'self#sort' do
  #   before :all do
  #     File.open 'test_dir/file_1.coffee', 'w' do |file|
  #       file.write 'modified'
  #     end
  #   end
  #   it 'unmodified files are sent to files_to_delete.txt' do
  #     RailsCleaner.sort 'test_dir/all_gen_files.txt','test_dir/files_to_delete.txt'
  #     expect(File.read('test_dir/files_to_delete.txt')).to match 'test_dir/files/file_1.txt'
  #   end
  # end
end
