# frozen_string_literal: true

require_relative '../lib/navigation_subsystem'
require 'minitest/autorun'

# Test NavigationSubsystem.
class NavigationSubsystemTest < Minitest::Test
  TEST_INPUT = [
    '[({(<(())[]>[[{[]{<()<>>',
    '[(()[<>])]({[<{<<[]>>(',
    '{([(<{}[<>[]}>{[]{[(<()>',
    '(((({<>}<{<{<>}{[]{[]{}',
    '[[<[([]))<([[{}[[()]]]',
    '[{[{({}]{}}([{[{{{}}([]',
    '{<[[]]>}<{[{[{[]{()[[[]',
    '[<(<(<(<{}))><([]([]()',
    '<{([([[(<>()){}]>(<<{{',
    '<{([{{}}[<[[[<>{}]]]>[]]'
  ].freeze

  def test_is_corrupt
    navigation = NavigationSubsystem.new(TEST_INPUT)
    assert_equal ['}', ')', ']', ')', '>'], navigation.corrupted_characters
  end

  def test_handles_invalid_input
    invalid_inputs = [nil, [], [''], [' ']]
    invalid_inputs.each do |invalid|
      error = assert_raises { NavigationSubsystem.new(invalid) }
      assert_equal 'InvalidInput', error.message
    end
  end
end
