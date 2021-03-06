require_relative "braille_translator"

class NightRead
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

  def process_content
    content = read_file_content
    braille_translator = BrailleDecoder.new
    braille_translator.to_words(content)
  end

  def write_new_file
    writer = File.open(@write_file, 'w')
    content = process_content
    char_count = writer.write(content)
    writer.rewind
    writer.close
    char_count
  end

  def message
    char_count = write_new_file
    p "Created '#{write_file}' containing #{char_count} characters"
  end

end

night_reader = NightRead.new
night_reader.message
