require_relative 'dictionary'

class Translator
  LINE_MAX = 80

  attr_accessor :words

  def initialize
    @words = words
  end

  def to_braille(words)
    characters = split_words(words)
    verified = verify(characters)
    caps_verified = has_caps?(verified) ? shift(verified) : verified
    translate(caps_verified)
  end

  def translate(characters, max = LINE_MAX)
    if characters.length < max
      encode(characters)
    else
      lines = line_divide(characters, max).map do |line|
        encode(line)
      end
      lines.join("\n\n")
    end
  end

  def encode(line)
    single_line_braille = to_braille_array(line)
    to_braille_string(single_line_braille)
  end

  def split_words(words)
    words.to_s.split("")
  end

  def verify(characters)
    verified = characters.map do |character|
      if character =~ /[\w |!|'|,|-|#|\.|\?]/
        character
      end
    end
    verified.compact
  end

  def has_caps?(characters)
    characters.any? do |character|
      character == character.upcase
    end
  end

  def shift(letters)
    shifted_letters = letters.map do |character|
      if character =~ /(?: |1|2|3|4|5|6|7|8|9|!|'|,|-|#|\.|\?)/
        character
      elsif character == character.upcase
       ["shift", character.downcase]
      else
       character
      end
    end
    shifted_letters.flatten
  end

  def to_braille_array(characters)
    characters.map do |character|
      Dictionary::CHARACTERS[character.downcase]
    end
  end

  def to_braille_string(characters)
    line_1 = characters.map do |character|
      character[0..1]
    end
    line_2 = characters.map do |character|
      character[2..3]
    end
    line_3 = characters.map do |character|
      character[4..5]
    end
    "#{line_1.join('')}\n#{line_2.join('')}\n#{line_3.join('')}"
  end

  def line_divide(characters, max = LINE_MAX)
    characters.each_slice(max).to_a
  end

end
