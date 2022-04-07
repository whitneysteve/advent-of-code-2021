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

  def test_filter_corrupt
    navigation = NavigationSubsystem.new(TEST_INPUT, filter_corrupt: true)
    assert_equal [], navigation.corrupted_characters
  end

  def test_corrupt_score
    navigation = NavigationSubsystem.new(TEST_INPUT, filter_corrupt: true)
    assert_equal [], navigation.corrupted_characters
  end

  def test_corrupt_score_invalid_input
    navigation = NavigationSubsystem.new(TEST_INPUT)
    invalid_inputs = [nil, '', ' ']
    invalid_inputs.each do |invalid|
      error = assert_raises { navigation.corruption_score(invalid) }
      assert_equal 'InvalidInput', error.message
    end
  end

  def test_corrupt_score_invalid_character
    error = assert_raises { NavigationSubsystem.new(TEST_INPUT).corruption_score('0') }
    assert_equal 'InvalidChar: 0', error.message
  end

  def test_auto_complete_input
    navigation = NavigationSubsystem.new(TEST_INPUT, filter_corrupt: true)
    assert_equal [
      '}}]])})]',
      ')}>]})',
      '}}>}>))))',
      ']]}}]}]}>',
      '])}>'
    ], navigation.auto_complete_input
  end

  def test_auto_complete_line_score
    navigation = NavigationSubsystem.new(TEST_INPUT)
    assert_equal 288_957, navigation.auto_complete_line_score('}}]])})]')
    assert_equal 5566, navigation.auto_complete_line_score(')}>]})')
    assert_equal 1_480_781, navigation.auto_complete_line_score('}}>}>))))')
    assert_equal 995_444, navigation.auto_complete_line_score(']]}}]}]}>')
    assert_equal 294, navigation.auto_complete_line_score('])}>')
  end

  def test_auto_complete_line_score_invalid_input
    navigation = NavigationSubsystem.new(TEST_INPUT)
    invalid_inputs = [nil, '', ' ']
    invalid_inputs.each do |invalid|
      error = assert_raises { navigation.auto_complete_line_score(invalid) }
      assert_equal 'InvalidInput', error.message
    end
  end

  def test_auto_complete_line_score_invalid_character
    error = assert_raises { NavigationSubsystem.new(TEST_INPUT).auto_complete_line_score(']]0]]') }
    assert_equal 'InvalidChar: 0', error.message
  end

  def test_handles_invalid_input
    invalid_inputs = [nil, [], [''], [' ']]
    invalid_inputs.each do |invalid|
      error = assert_raises { NavigationSubsystem.new(invalid) }
      assert_equal 'InvalidInput', error.message
    end
  end
end
