require 'pry'

class Runner
  attr_reader :read_file, :write_file

  def initialize(input_array = ARGV)
    @read_file = input_array[0]
    @write_file = input_array[1]
  end

  def read_file_content
    handle = File.open(@read_file, 'r')
    content = handle.read
    handle.close
    content
  end

  def process_content #eventually for translate
    read_file_content.upcase
  end

  def write_new_file
    writer = File.open(@write_file, 'w')
    characters = writer.write(process_content)
    writer.rewind
    writer.close
    characters
  end

  def message
    p "Created '#{ARGV[1]}' containing #{write_file} characters"
  end

end

r = Runner.new
r.message
