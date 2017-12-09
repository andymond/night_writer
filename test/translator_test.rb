require './lib/translator'
require 'minitest/autorun'
require 'minitest/pride'

class TranslatorTest < MiniTest::Test

  def test_it_exists
    translator = Translator.new

    assert_instance_of Translator, translator
  end

  def test_input_1_output_3_on_newlines
    translator = Translator.new

    assert_equal "hey\nhey\nhey", translator.threelines("hey")
  end

  def test_braille_array_of_strings
    translator = Translator.new

    assert_equal ["0....."], translator.english_to_braille_array_of_strings("a")
    assert_equal ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00."], translator.english_to_braille_array_of_strings("Hello")
  end

  def test_split_one_line_braille_every_other
    translator = Translator.new

    assert_equal ["0.", "..", ".."], translator.split_every_other("0.....")
  end

  def test_three_line_braille_conversion
    skip
    translator = Translator.new

    assert_equal "0.\n00\n..", translator.three_line_braille("0.00..")
  end

end
