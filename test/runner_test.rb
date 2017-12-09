require './lib/runner'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class RunnerTest < Minitest::Test

  def test_read_file_content_returns_content
    runner = Runner.new(["./lib/message.txt"])
    `echo "Content" > ./lib/message.txt`

    assert_equal "Content\n", runner.read_file_content
  end

  def test_process_content
    runner = Runner.new(["./lib/message.txt"])
    `echo "Content" > ./lib/message.txt`

    assert_equal "CONTENT\n", runner.process_content
  end

  def test_write_new_file_returns_character_count
    runner = Runner.new(["./lib/message.txt", "./lib/message_copy.txt"])
    `echo "Content" > ./lib/message.txt`

    assert_equal "Content\n".length, runner.write_new_file
  end


  def test_message
    runner = Runner.new(["./lib/message.txt", "./lib/message_copy.txt"])
    `echo "Content" > ./lib/message.txt`

    assert_equal "Created './lib/message_copy.txt' containing 8 characters", runner.message
  end

end
