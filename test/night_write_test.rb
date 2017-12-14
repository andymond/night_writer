require './lib/night_write'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class RunnerTest < Minitest::Test

  def test_read_file_content_returns_content
    runner = NightWrite.new(["./data/test_file.txt"])
    `echo "Content" > ./data/test_file.txt`

    assert_equal "Content\n", runner.read_file_content
  end

  def test_process_content
    runner = NightWrite.new(["./data/test_file.txt"])
    `echo "Content" > ./data/test_file.txt`

    assert_equal "..000.00.00.00.0\n.....0.000.0.000\n.0..0.0.0...0.0.", runner.process_content
  end

  def test_write_new_file_returns_character_count
    runner = NightWrite.new(["./data/test_file.txt", "./data/test_copy.txt"])
    `echo "Content" > ./data/test_file.txt`

    assert_equal "..000.00.00.00.0\n.....0.000.0.000\n.0..0.0.0...0.0.".length, runner.write_new_file
  end


  def test_message
    runner = NightWrite.new(["./data/test_file.txt", "./data/test_copy.txt"])
    `echo "Content" > ./data/test_file.txt`

    assert_equal "Created './data/test_copy.txt' containing 8 characters", runner.message
  end

end
