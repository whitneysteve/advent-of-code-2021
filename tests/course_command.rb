# frozen_string_literal: true

require_relative '../lib/course_command'
require 'minitest/autorun'

# Test for course command parser.
class CourseCommandTest < Minitest::Test
  def test_should_parse_valid_commands
    command = CourseCommand.parse(' forward 1')
    assert command.horizontal?
    assert command.distance == 1
    command = CourseCommand.parse('up 10000')
    assert command.depth?
    assert command.distance == -10_000
    command = CourseCommand.parse('down 55.5')
    assert command.depth?
    assert command.distance == 55
  end

  INVALID_COMMANDS = [
    nil,
    '',
    ' ',
    'nonsense',
    'nonsense 10',
    'forward',
    'forward ',
    'forward abc',
    '10',
    'forward -10'
  ].freeze

  def test_should_not_parse_invalid_command
    INVALID_COMMANDS.each do |invalid_str|
      assert CourseCommand.parse(invalid_str).nil?
    end
  end
end
