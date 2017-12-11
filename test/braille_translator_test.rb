require './lib/braille_translator'
require 'minitest/autorun'
require 'minitest/pride'

class TranslatorTest < MiniTest::Test

  def test_it_exists
    translator = BrailleDecoder.new

    assert_instance_of BrailleDecoder, translator
  end

  def test_process_line_breaks_divides_braille_line_breaks
    translator = BrailleDecoder.new

    assert_equal ["0.0.\n....\n....", "0.0.\n....\n...."], translator.process_line_breaks("0.0.\n....\n....\n\n0.0.\n....\n....")
  end

  def test_split_lines_splits_single_braille_lines_on_line_breakes
    translator = BrailleDecoder.new

    assert_equal ["0.0.", "....", "...."], translator.split_lines("0.0.\n....\n....")
  end

  def test_3_to_1_line_converts_line_broken_to_no_break_strings
    skip
    translator = BrailleDecoder.new

    assert_equal ["0.....", "0....."], translator.three_to_one_line(["0.0.", "....", "...."])
  end

  def test_verification_process_works
    skip
    translator = BrailleDecoder.new

    assert_equal ["0.....", "0....."], translator.verify_braille(["0.....", "0.....", "o..o.."])
  end

  def test_braille_to_character_converter_works
    skip
    translator = BrailleDecoder.new

    assert_equal ["a", "a"], translator.to_characters(["0.....", "0....."])
  end

end
