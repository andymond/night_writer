require 'pry'

class Runner

  attr_accessor :input_array

  def initialize
    @input_array = ARGV
  end

  def read_file
    handle = File.open(@input_array[0], 'r')
    content = handle.read
    handle.close
    content
  end

  def process_content #eventually for translate
    read_file.upcase
  end

  def write_file
    writer = File.open(@input_array[1], 'w')
    @characters = writer.write(process_content)
    writer.close
    @characters
  end

  def message
    write_file
    puts "Created '#{ARGV[1]}' containing #{@characters} characters"
  end

end

runner = Runner.new
runner.message
