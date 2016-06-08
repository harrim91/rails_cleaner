require "rails_cleaner/version"

module RailsCleaner
  def self.hello
    puts "Hello world"
  end

  def self.init(to)
    files = Dir.glob("**/*")
    array = []
    files.each do |file|
    if file.match(/.(scss|coffee|rb)/)
    array << file
  end
  File.open (to), "w" do |f|
    array.each do |line|
      f.write line + "\n"
      end
    end
  end

  def self.sort(from,to)
    new_array = []
      File.foreach(from) do |line|
      file = line.strip.gsub("'", "")
        if File.ctime(file)==File.birthtime(file)
          new_array << file
        end
      File.open to, "w" do |f|
        new_array.each do |line|
          f.write line + "\n"
        end
      end
    end
  end
end
