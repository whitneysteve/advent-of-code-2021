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

  # invalid input - nil, empty, all_blank, all_empty
end
