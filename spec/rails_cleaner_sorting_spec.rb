require 'spec_helper'

describe RailsCleaner do

  before(:all) do
    File.truncate('test_dir2/files_to_delete.txt',0)
  end

  it 'file 1 has not been modified' do
    expect(File.ctime('test_dir2/files/file_1.txt')).to eq(File.birthtime('test_dir2/files/file_1.txt'))
  end

  it 'file 2 has been modified' do
    expect(File.ctime('test_dir2/files/file_2.txt')).not_to eq(File.birthtime('test_dir2/files/file_2.txt'))
  end

  it 'unmodified files are sent to "files_to_delete.txt"' do
    expect(File.read('test_dir2/files_to_delete.txt')).not_to match 'test_dir2/files/file_1.txt'
    RailsCleaner.sort("test_dir2/all_gen_files.txt","test_dir2/files_to_delete.txt")
    expect(File.read('test_dir2/files_to_delete.txt')).to match 'test_dir2/files/file_1.txt'
  end
end
