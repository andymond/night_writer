class BrailleDecoder
    LINE_MAX = 160

    attr_accessor :braille

  def initialize
    @braille = braille
  end

  def to_words(lines)
    divided_lines = process_line_breaks(lines)
    one_line_braille = three_to_one_line(divided_lines)
    verified = verify_braille(one_line_braille)
    characters = to_characters(verified)
    caps_converted = has_shifts?(characters) ? capitalize(characters) : characters
    decode(caps_converted)
  end

  def process_line_breaks(lines)
    lines.split("\n\n")
  end

  def split_lines(line_arrays)
    line_arrays.split("\n")
  end

  def three_to_one_line(lines)
    (lines.length/2).times.map do
      lines.map do |line|
        line.slice!(0..1)
      end.join('')
    end
  end

end
