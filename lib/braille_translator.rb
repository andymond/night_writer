require_relative 'dictionary'

class BrailleDecoder
    LINE_MAX = 80

    attr_accessor :braille

  def initialize
    @braille = braille
  end

  def to_words(lines)
    single_lines = process_line_breaks(lines)
    divided_lines = split_line(single_lines)
    one_line_braille = three_to_one_line(divided_lines)
    characters = to_characters(one_line_braille)
    caps_converted = has_shifts?(characters) ? capitalize(characters) : characters
    translate(caps_converted)
  end

  def process_line_breaks(lines)
    lines.split("\n\n")
  end

  def split_line(line_array)
    line_array.split("\n")
  end

  def three_to_one_line(lines)
    (lines.length/2).times.map do
      lines.map do |line|
        line.slice!(0..1)
      end.join('')
    end
  end

  def to_characters(braille_array)
    braille_array.map do |braille|
      Dictionary::CHARACTERS.key(braille)
    end
  end

  def has_shifts?(character_array)
    character_array.any? do |character|
      character == "shift"
    end
  end

  def capitalize(character_array)
    character_array.map.with_index do |character, i|
      if character == "shift"
        character_array[i + 1].upcase!
        character_array.delete_at(i)
      else
        character
      end
    end
    character_array
  end

  def character_string(character_array)
    character_array.join('')
  end

  def inject_line_breaks(line, max = LINE_MAX)
    if line.length > max
        lines = line.chars.each_slice(max).to_a
        lines.map do |character_array|
        character_array.join
      end.join("\n")
    else
      line
    end
  end

  def translate(character_array, max = LINE_MAX)
    line = character_string(character_array)
    inject_line_breaks(line, max)
  end

end
