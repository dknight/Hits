class Model
  
  @path = nil
  @name = nil
  
  def initialize(name)
    @name = name
    @path = File.dirname(__FILE__) + "/log/#{name}.txt"
    #if !File.exists?(@path)
    #  File.open(@path, "w") {|f| f.write "0" } rescue "Cannot create file #{name}.txt"
    #end
  end
  
  def increment
    number = File.open(@path, "r") {|f| f.read }
    number = number.to_i + 1
    File.open(@path, "w") do |f|
      # Lock and unlock file to avoid multiple access
      f.flock(File::LOCK_EX)
      f.puts number.to_s
      f.flock(File::LOCK_UN)
    end
    number
  end
  
  def get_count
    File.open(@path, "r") {|f| f.read.to_i }
  end
  
  def human_name
    @name.gsub(/_-/, ' ').capitalize
  end
  
  def self.get_all
    ['tux', 'ruby', 'msn', 'heart']
  end
  
  def self.random
    all = self.get_all
    all[rand(all.length)]
  end
  
  private
  
  def self.exists?(name)
    self.get_all.include?(name)
  end
  
end