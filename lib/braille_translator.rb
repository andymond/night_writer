require_relative 'dictionary'

class BrailleDecoder
    LINE_MAX = 80

    attr_accessor :braille

  def initialize
    @braille = braille
  end

  def to_words(lines)
    single_lines = process_line_breaks(lines)
    divided_lines = split_multi_lines(single_lines)
    one_line_braille = multi_line_converter(divided_lines)
    characters = to_characters_multi_line(one_line_braille)
    caps_converted = have_shifts?(characters) ? capitalize_multi(characters) : characters
    translate_multi(caps_converted)
  end

  def to_words_one_line(braille)
    separated_lines = split_line(braille)
    one_line_braille = three_to_one_line(separated_lines)
    characters = to_characters(one_line_braille)
    caps_converted = has_shifts?(characters) ? capitalize(characters) : characters
    translate(caps_converted)
  end

  def process_line_breaks(lines)
    lines.split("\n\n")
  end

  def split_line(line)
    line.split("\n")
  end

  def split_multi_lines(line_array)
    line_array.map do |line|
      split_line(line)
    end
  end

  def three_to_one_line(lines)
    (lines.first.length/2).times.map do
      lines.map do |line|
        line.slice!(0..1)
      end.join('')
    end
  end

  def multi_line_converter(nested_line_array)
    nested_line_array.map do |line|
      three_to_one_line(line)
    end
  end

  def to_characters(braille_array)
    braille_array.map do |braille|
      Dictionary::CHARACTERS.key(braille)
    end
  end

  def to_characters_multi_line(nested_braille_array)
    nested_braille_array.map do |braille_array|
      to_characters(braille_array)
    end
  end

  def has_shifts?(character_array)
    character_array.any? do |character|
      character == "shift"
    end
  end

  def have_shifts?(nested_character_array)
    nested_character_array.map do |character_array|
      has_shifts?(character_array)
    end
  end

  def capitalize(character_array)
    character_array.map.with_index do |character, i|
      if character == "shift"
        a = character_array[i + 1].upcase
        character_array.delete_at(i)
        a
      else
        character
      end
    end
  end

  def capitalize_multi(nested_character_array)
    nested_character_array.map do |character_array|
      capitalize(character_array)
    end
  end

  def character_string(character_array)
    character_array.join('')
  end

  def character_string_multi(nested_character_array)
    nested_character_array.map do |character_array|
      character_string(character_array)
    end
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

  def translate_multi(nested_character_array)
    nested_character_array.map do |character_array|
      translate(character_array)
    end.join
  end

end
