require 'simplecov'
SimpleCov.start
require './lib/text_translator'
require 'minitest/autorun'
require 'minitest/pride'

class TranslatorTest < MiniTest::Test

  def test_it_exists
    translator = Translator.new

    assert_instance_of Translator, translator
  end

  def test_split_words_works
    translator = Translator.new

    assert_equal ["h", "e", "l", "l", "o"], translator.split_words("hello")
    assert_equal ["1", "$", "A", "^"], translator.split_words("1$A^")
  end

  def test_verify_characters_removes_chars_not_in_dictionary
    translator = Translator.new

    assert_equal ["h", "e", "l", "l", "o"], translator.verify(["h", "e", "l", "l", "o"])
    assert_equal ["h", "#", "l", "l"], translator.verify(["h", "#", "@", "l", "l", "*", ")", "~"])
  end

  def test_has_caps_returns_true_for_caps_false_for_non
    translator = Translator.new

    assert_equal true, translator.has_caps?(["A"])
    assert_equal false, translator.has_caps?(["b"])
  end

  def test_shift_works
    translator = Translator.new

    assert_equal ["shift", "h", "shift", "e", "shift", "l", "shift", "l", "o"], translator.shift(["H", "E", "L", "L", "o"])
    assert_equal ["h", "i", "!", "shift", "@", "shift", "b"], translator.shift(["h","i", "!", "@", "B"])
  end

  def test_number_works
    translator = Translator.new

    assert_equal ["#", "1", " "], translator.number(["1"])
    assert_equal ["#", "1", "1", " "], translator.number(["1", "1"])
    assert_equal ["a"], translator.number(["a"])
  end

  def test_to_braille_array_works
    translator = Translator.new

    assert_equal ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00."], translator.to_braille_array(["h", "e", "l", "l", "o"])
  end

  def test_to_braille_string_works
    translator = Translator.new

    assert_equal "oh\nhi\noh", translator.to_braille_string(["ohhioh"])
    assert_equal "0.0.\n....\n....", translator.to_braille_string(["0.....", "0....."])
  end

  def test_line_divide_converts_array_of_strings_into_array_specific_length_arrays
    translator = Translator.new

    assert_equal [["hi", "my"],["name", "is"], ["Andy"]], translator.line_divide(["hi", "my", "name", "is", "Andy"], 2)
  end

  def test_encode_takes_key_character_array_and_returns_braille_strings
    translator = Translator.new

    assert_equal "0.0.\n....\n....", translator.encode(["a", "a"])
  end

  def test_translate_takes_key_character_array_returns_braille_strings_with_line_breaks
    translator = Translator.new

    assert_equal "0.0.\n....\n....", translator.translate(["a", "a"])
    assert_equal "0.\n..\n..\n\n0.\n..\n..", translator.translate(["a", "a"], 1)
  end

  def test_to_braille_takes_string_returns_braille_with_proper_returns
    translator = Translator.new

    assert_equal "0.\n..\n..", translator.to_braille("a")
    assert_equal "0.0.\n....\n....", translator.to_braille("a@a")
    assert_equal "\n\n", translator.to_braille("@@@@@@@@@@")
    assert_equal "..0.\n..00\n.0..", translator.to_braille("H")
  end

end
