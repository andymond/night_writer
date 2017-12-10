require './lib/translator'
require 'minitest/autorun'
require 'minitest/pride'

class TranslatorTest < MiniTest::Test

  def test_it_exists
    translator = Translator.new

    assert_instance_of Translator, translator
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

  def test_braille_array_of_strings
    translator = Translator.new

    assert_equal ["0....."], translator.chars_to_braille_array("a")
    assert_equal ["......"], translator.chars_to_braille_array(" ")
    assert_equal ["0.....", "0.0...", "00....", "..0.00", "0.....", "0.0...", "00...."], translator.chars_to_braille_array("123?abc")
    assert_equal ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00."], translator.chars_to_braille_array("hello")
  end

  def test_shift_correlated_with_only_capital_letters
    translator = Translator.new

    assert_equal ["shift", "a", "shift", "b", "shift", "c"], translator.capital_letters("ABC")
    assert_equal ["shift", "a", "n", "d", "y"], translator.capital_letters("Andy")
    assert_equal ["a", "n", "d", "y"], translator.capital_letters("andy")
    assert_equal translator.split_words("lowcase"), translator.capital_letters("lowcase")
    assert_equal [" "], translator.capital_letters(" ")
    #assert_equal ["$"], translator.capital_letters("$")
  end

  def test_character_verification_works
    translator = Translator.new

    assert_equal ["a", "b", "4"], translator.character_verification("ab4$%^&*")
    assert_equal ["A", ".", "!", " ", " "], translator.character_verification("A.!  ")
  end

  def test_line_length
    translator = Translator.new

    assert_equal 10, translator.line_length("hello")
    assert_equal 28, translator.line_length("oh! Hey ther3")
    assert_equal 92, translator.line_length("WOAHHHHHHH   THAT! IS, GR3@t!")
  end

  def test_line_length_limit
    skip
    translator = Translator.new

    assert_equal 160, translator.line_limiter("askdjfhasdlkfahsdfakjsdfhalsdkfjahdsflakjsdfhalskjdfhasldkfjahsdflaksjdfhasdlfkjah      dsaflkjsdh asd")
  end

  def test_line_divide
    skip
    translator = Translator.new

    assert_equal "hey" "hey", translator.line_divide("hey hey")
  end

  def test_line_return
    skip
    translator = Translator.new

    assert_equal "hey" "hey", translator.line_divide("hey hey")
    assert_equal "hey\nhey", translator.line_return("hey hey")
  end

end
