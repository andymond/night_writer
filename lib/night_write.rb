# require_relative "text_translator"
# require_relative "braille_translator"

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
    char_count = writer.write(process_content)
    writer.rewind
    writer.close
    char_count
  end

  def message
    char_count = write_new_file
    p "Created '#{write_file}' containing #{char_count} characters"
  end

end

night_writer = Runner.new
night_writer.message
