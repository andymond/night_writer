#require_relative 'dictionary'

class Translator

  attr_accessor :words

  def initialize(words = "hey")
    @words = words
  end
#add caps as distinct characters?
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
    " "=>" ",
    "shift"=>".....0"
  }

  def split_words(words)
    words.to_s.split("")
  end

  def threelines(element)
    "#{element}\n#{element}\n#{element}"
  end

  def english_to_braille_array_of_strings(words)
    english = split_words(words)
    braille = english.map do |character|
      DICTIONARY[character.downcase]
    end
    braille
  end

  def braille_string(words)
    one_line_braille(words).join('')
  end

  def split_every_other(words)
    braille_string(words).scan(/../)
  end


end
