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

  def test_split_line_splits_single_braille_lines_on_line_breaks
    translator = BrailleDecoder.new

    assert_equal ["0.0.", "....", "...."], translator.split_line("0.0.\n....\n....")
  end

  def test_split_multi_lines_can_split_lines_in_array
    translator = BrailleDecoder.new

    assert_equal [["0.0.", "....", "...."]], translator.split_multi_lines(["0.0.\n....\n...."])
    assert_equal [["0.0.", "....", "...."], ["0.0.", "....", "...."]], translator.split_multi_lines(["0.0.\n....\n....", "0.0.\n....\n...."])
  end

  def test_3_to_1_line_converts_line_broken_to_no_break_strings
    translator = BrailleDecoder.new

    assert_equal ["0.....", "0....."], translator.three_to_one_line(["0.0.", "....", "...."])
  end

  def test_multi_line_converter_converts_multiple_braille_lines_into_string_arrays
    translator = BrailleDecoder.new

    assert_equal [["0.....", "0....."]], translator.multi_line_converter([["0.0.", "....", "...."]])
    assert_equal [["0.....", "0....."], ["0.....", "0....."]], translator.multi_line_converter([["0.0.", "....", "...."], ["0.0.", "....", "...."]])
  end

  def test_verification_process_works
    skip
    translator = BrailleDecoder.new

    assert_equal ["0.....", "0....."], translator.verify_braille(["0.....", "0.....", "o..o.."])
  end

  def test_braille_to_characters_takes_one_line_braille_and_returns_text_array
    translator = BrailleDecoder.new

    assert_equal ["a", "a"], translator.to_characters(["0.....", "0....."])
    assert_equal ["shift", "b"], translator.to_characters([".....0", "0.0..."])
    assert_equal [" "], translator.to_characters(["......"])
  end

  def test_braile_to_char_works_for_multiple_lines
    translator = BrailleDecoder.new

    assert_equal [["a", "a"]], translator.to_characters_multi_line([["0.....", "0....."]])
    assert_equal [["shift", "b"], ["z", "q"]], translator.to_characters_multi_line([[".....0", "0.0..."], ["0..000", "00000."]])
    assert_equal [[" "], ["!"]], translator.to_characters_multi_line([["......"], ["..000."]])
  end

  def test_has_shifts_method_detects_shifts_in_array
    translator = BrailleDecoder.new

    assert_equal true, translator.has_shifts?(["shift", "b"])
    refute_equal true, translator.has_shifts?(["a", "z"])
  end

  def test_have_shifts_detects_shifts_in_nested_arrays
    translator = BrailleDecoder.new

    assert_equal [true], translator.have_shifts?([["shift", "b"]])
    assert_equal [true, true], translator.have_shifts?([["shift", "b"], ["shift", "b"]])
    refute_equal [true], translator.have_shifts?([["a", "z"]])
  end

  def test_capitalize_method_converts_shift_and_following_letter_to_caps
    translator = BrailleDecoder.new

    assert_equal ["A", "B"], translator.capitalize(["shift", "a", "shift", "b"])
    assert_equal ["A", "B", "c", "d", "!"], translator.capitalize(["shift", "a", "shift", "b", "c", "d", "!"])
  end

  def test_capitalize_multi_works_in_nested_arrays
    translator = BrailleDecoder.new

    assert_equal [["A", "B"]], translator.capitalize_multi([["shift", "a", "shift", "b"]])
    assert_equal [["A", "B"], ["c", "d", "!"]], translator.capitalize_multi([["shift", "a", "shift", "b"], ["c", "d", "!"]])
  end

  def test_character_string_returns_string_of_characters_and_spaces
    translator = BrailleDecoder.new

    assert_equal "Hi my name is", translator.character_string(["H", "i", " ", "m", "y", " ", "n", "a", "m", "e", " ", "i", "s"])
    assert_equal "O", translator.character_string(["O"])
  end

  def test_character_string_multi_joins_nested_character_arrays
    translator = BrailleDecoder.new

    assert_equal ["Hi", "my", "name"], translator.character_string_multi([["H", "i"], ["m", "y"], ["n", "a", "m", "e"]])
    assert_equal ["O"], translator.character_string_multi([["O"]])
  end

  def test_inject_line_breaks_inserts_breaks_into_strings_based_on_max
    translator = BrailleDecoder.new

    assert_equal "Hi \nmy \nnam\ne i\ns", translator.inject_line_breaks("Hi my name is", 3)
  end

  def test_translate_takes_character_array_and_returns_lines_with_breaks
    translator = BrailleDecoder.new

    assert_equal "Hi \nmy \nnam\ne i\ns", translator.translate(["H", "i", " ", "m", "y", " ", "n", "a", "m", "e", " ", "i", "s"], 3)
    assert_equal "Hi my name is", translator.translate(["H", "i", " ", "m", "y", " ", "n", "a", "m", "e", " ", "i", "s"])
  end

  def test_translate_multi_takes_nested_character_array_and_returns_lines_with_breaks
    translator = BrailleDecoder.new

    assert_equal "Hi \nmy \nnam\ne i\ns", translator.translate([["H", "i", " ", "m", "y", " ", "n", "a", "m", "e", " ", "i", "s"]], 3)
    assert_equal "Hi my name is", translator.translate([["H", "i", " ", "m", "y", " ", "n", "a", "m", "e", " ", "i", "s"]])
  end

  def test_to_words_one_line_takes_one_line_of_braille_and_returns_line_of_alpha
    translator = BrailleDecoder.new

    assert_equal "a", translator.to_words_one_line("0.\n..\n..")
    assert_equal "aa", translator.to_words_one_line("0.0.\n....\n....")
    assert_equal "ey!", translator.to_words_one_line("0.00..\n.0.000\n..000.")
    assert_equal "H", translator.to_words_one_line("..0.\n..00\n.0..")
  end

  def test_to_words_takes_multiple_lines_of_braille_and_returns_line_of_alpha
    translator = BrailleDecoder.new

    assert_equal "a", translator.to_words("0.\n..\n..")
    assert_equal "aa", translator.to_words("0.0.\n....\n....")
    assert_equal "ey!", translator.to_words("0.00..\n.0.000\n..000.")
    assert_equal "H", translator.to_words("..0.\n..00\n.0..")
    assert_equal "HeyHey", translator.to_words("..0.0.00\n..00.0.0\n.0....00\n\n..0.0.00\n..00.0.0\n.0....00")
  end

end
