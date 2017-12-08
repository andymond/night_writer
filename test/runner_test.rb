require '../lib/runner'
require 'minitest/autorun'
require 'minitest/pride'

class TestRunner < Minitest::Test

  def test_read_file_returns_content
    runner = Runner.new
    runner.input_array << "content"

    assert_equal "content", runner.read_file
  end

  def test_write_file
    skip
    runner = Runner.new

    assert runner.write_file
  end

  def test_process_content
    skip
    runner = Runner.new

    assert runner.process_content
  end

  def test_message
    skip
    runner = Runner.new

    assert runner.message
  end

end
