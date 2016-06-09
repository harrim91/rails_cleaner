require 'spec_helper'
























































































































































































































































describe RailsCleaner do
  it 'has a version number' do
    expect(RailsCleaner::VERSION).not_to be nil
  end

  # it 'does something useful' do
  #   expect(false).to eq(true)
  # end

  describe "#delete" do
    it 'deletes the file that you pass to it' do
      test_file = File.new("./test_dir/test_file", "w")
      test_file.write("test")
      test_file.close
      expect(Dir.entries("./test_dir").include?("test_file")).to eq(true)
      RailsCleaner.delete("test_dir/test_file")
      expect(Dir.entries("./test_dir").include?("test_file")).to eq(false)
    end
  end

  describe "#delete_from" do
    it 'deletes all the file paths in a text file' do
      test_file = File.new("./test_dir/hello", "w")
      test_file.write("test")
      test_file.close
      test_file = File.new("./test_dir/hi", "w")
      test_file.write("test")
      test_file.close
      # expect(Dir.entries("./test_dir")).to eq([".", "..", "hello", "hi"])
      test_file = File.new("./test_dir/delete.txt", "w")
      test_file.write("'./test_dir/hello', './test_dir/hi', './test_dir/delete.txt'")
      test_file.close
      RailsCleaner.delete_from('./test_dir/delete.txt')
      expect(Dir.entries("./test_dir").include?("hello")).to eq(false)
      expect(Dir.entries("./test_dir").include?("hi")).to eq(false)
      expect(Dir.entries("./test_dir").include?("delete.txt")).to eq(false)
    end

    # it 'returns an array of all the files you want to delete' do
    #   test_file = File.new("./test_dir/delete.txt", "w")
    #   test_file.write("'./test_dir/hello', './test_dir/hi', './test_dir/delete.txt'")
    #   test_file.close
    #   expect(RailsCleaner.delete_from('./test_dir/delete.txt')).to eq(['./test_dir/hello', './test_dir/hi', './test_dir/delete.txt'])
    # end
  end
end
