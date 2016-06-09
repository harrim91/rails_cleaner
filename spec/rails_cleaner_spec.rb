require 'spec_helper'

describe RailsCleaner do

  subject(:rails_cleaner) { described_class }

  before :all do
    Dir.mkdir 'test_dir'
    Dir.mkdir 'test_dir/dir1'
    File.open 'test_dir/file.coffee', 'w'
    File.open 'test_dir/dir1/file1.coffee', 'w'
    File.open 'test_dir/file.scss', 'w'
    File.open 'test_dir/file.rb', 'w'
  end

  after :each do
    FileUtils.rm_r '.rails_cleaner'
  end

  after :all do
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
      expect(File.read '.rails_cleaner/tracked_files.txt').to match /test_dir\/file.coffee/
    end

    it 'adds all .scss files in a given path to tracked_files.txt' do
      rails_cleaner.init
      rails_cleaner.track 'test_dir'
      expect(File.read '.rails_cleaner/tracked_files.txt').to match /test_dir\/file.scss/
    end

    it 'searches through subdirectories' do
      rails_cleaner.init
      rails_cleaner.track 'test_dir'
      expect(File.read '.rails_cleaner/tracked_files.txt').to match /test_dir\/dir1\/file1.coffee/
    end

    it 'doesn\'t add other files' do
      rails_cleaner.init
      rails_cleaner.track 'test_dir'
      expect(File.read '.rails_cleaner/tracked_files.txt').not_to match /test_dir\/file.rb/
    end
  end

  describe 'self#sort' do
    before :each do
      sleep 1
      File.open 'test_dir/file.coffee', 'w' do |file|
        file.write 'modified'
      end
    end

    it 'writes unmodified files to files_to_delete.txt' do
      rails_cleaner.init
      rails_cleaner.track 'test_dir'
      rails_cleaner.sort
      expect(File.read('.rails_cleaner/files_to_delete.txt')).to match 'test_dir/file.scss'
    end

    it 'doesn\t write modified files' do
      rails_cleaner.init
      rails_cleaner.track 'test_dir'
      rails_cleaner.sort
      expect(File.read('.rails_cleaner/files_to_delete.txt')).not_to match 'test_dir/file.coffee'
    end
  end

end
