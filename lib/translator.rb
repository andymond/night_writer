#require_relative 'dictionary'

class Translator

  attr_accessor :words

  def initialize(words = "hey")
    @words = words
  end
  DICTIONARY = {
    "a"=>"0.....",
    "b"=>"0.0...",
    "c"=>"00....",
    "d"=>"00.0..",
    "e"=>"0..0..",
    "f"=>"000...",
    "g"=>"0000..",
    "h"=>"0.00..",
    "i"=>".00...",
    "j"=>".000..",
    "k"=>"0...0.",
    "l"=>"0.0.0.",
    "m"=>"00..0.",
    "n"=>"00.00.",
    "o"=>"0..00.",
    "p"=>"000.0.",
    "q"=>"00000.",
    "r"=>"0.000.",
    "s"=>".00.0.",
    "t"=>".0000.",
    "u"=>"0...00",
    "v"=>"0.0.00",
    "w"=>".000.0",
    "x"=>"00..00",
    "y"=>"00.000",
    "z"=>"0..000",
    "shift"=>".....0",
    " "=>"......",
    "!"=>"..000.",
    "'"=>"....0.",
    ","=>"..0...",
    "-"=>"....00",
    "."=>"..00.0",
    "?"=>"..0.00",
    "#"=>".0.000",
    "0"=>".000..",
    "1"=>"0.....",
    "2"=>"0.0...",
    "3"=>"00....",
    "4"=>"00.0..",
    "5"=>"0..0..",
    "6"=>"000...",
    "7"=>"0000..",
    "8"=>"0.00..",
    "9"=>".00..."
  }

  def split_words(words)
    words.to_s.split("")
  end

  def character_verification(words)
    verified = split_words(words).map do |char|
      if char =~ /[\w |!|'|,|-|#|\.|\?]/
        char
      end
    end
    verified.compact
  end

  def capital_letters(words)
    shifted_letters = character_verification(words).map do |char|
      if char =~ /(?: |1|2|3|4|5|6|7|8|9|!|'|,|-|#|\.|\?)/
        char
      elsif char == char.upcase
       ["shift", char.downcase]
      else
       char
      end
    end
    shifted_letters.flatten
  end

  def chars_to_braille_array(words)
    chars = capital_letters(words)
    braille = chars.map do |character|
      DICTIONARY[character.downcase]
    end
    braille
  end

  def threelines(words)
    line_1 = chars_to_braille_array(words).map do |letter|
      letter[0..1]
    end
    line_2 = chars_to_braille_array(words).map do |letter|
      letter[2..3]
    end
    line_3 = chars_to_braille_array(words).map do |letter|
      letter[4..5]
    end
    "#{line_1.join('')}\n#{line_2.join('')}\n#{line_3.join('')}"
  end

  def line_length(words)
    (threelines(words).length - 2) / 3
  end

  def line_limiter(words)
    #sets line_length cap to 160, calls line divide?

  end

  def line_divide(words)
    # divides line
  end

  def line_return(words)
    #takes divided lines and adds \n for return after line3 of braille string
  end

end
