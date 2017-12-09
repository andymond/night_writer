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

    assert_equal ["0....."], translator.chars_to_braille_array("a")
    assert_equal ["......"], translator.chars_to_braille_array(" ")
    assert_equal ["0.....", "0.0...", "00....", "..0.00", "0.....", "0.0...", "00...."], translator.chars_to_braille_array("123?abc")
    assert_equal ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00."], translator.chars_to_braille_array("Hello")
  end

  def test_input_letter_output_braille_on_newlines
    translator = Translator.new

    assert_equal "0.\n00\n..", translator.threelines("h")
    assert_equal "0.\n.0\n00", translator.threelines("z")
    assert_equal "..\n..\n..", translator.threelines(" ")
    assert_equal "0..0\n000.\n....", translator.threelines("hi")
    assert_equal "0.0.0.0.0.\n00.00.0..0\n....0.0.0.", translator.threelines("hello")
    assert_equal "0..0..0.0.0.0.0.\n000...00.00.0..0\n..........0.0.0.", translator.threelines("hi hello")
  end

  def test_character_verification_works
    skip
    translator = Translator.new

    assert_equal "0.....", translator.character_verification("a")
    assert_equal "??????", translator.character_verification("$")
  end

  def test_unexpected_input
    skip
    translator = Translator.new

    assert_equal ["??????"], translator.chars_to_braille_array("@")
    assert_equal ["??????", "??????", "??????", "0....."], translator.chars_to_braille_array("*&^1")

  end

end
