require './lib/translator'
require 'minitest/autorun'
require 'minitest/pride'

class TranslatorTest < MiniTest::Test

  def test_it_exists
    translator = Translator.new

    assert_instance_of Translator, translator
  end

  def test_braille_array_of_strings
    translator = Translator.new

    assert_equal ["0....."], translator.english_to_braille_array("a")
    assert_equal ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00."], translator.english_to_braille_array("Hello")
  end

  def test_braile_string_joins_array
    translator = Translator.new

    assert_equal "0.....", translator.braille_string("a")
    assert_equal "0..... 00.00. 00.0.. 00.000", translator.braille_string("a n d y")
  end

  def test_input_letter_output_braille_on_newlines
    translator = Translator.new

    assert_equal "0.\n00\n..", translator.threelines("h")
    assert_equal "0.\n.0\n00", translator.threelines("z")
    assert_equal " \n\n", translator.threelines(" ")
  end

  def test_input_word_output_braille_array
    skip
    translator = Translator.new

    assert_equal ["0.\n00\n..", ".0\n0.\n.."], word_to_braille_array("hi")

  end


end
