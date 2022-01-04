# frozen_string_literal: true

require_relative '../lib/sonar'
require 'minitest/autorun'

# Test for challenge 1.
class SonarTest < Minitest::Test
  TEST_ARRAY = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263].freeze
  TEST_ARRAY_WITH_NIL = [199, 200, 208, 210, 200, 207, 240, 269, nil, 263].freeze

  def test_counts_increases
    assert Sonar.count_increases(TEST_ARRAY) == 7
  end

  def test_handles_nil
    assert Sonar.count_increases(nil).zero?
  end

  def test_handles_empty_array
    assert Sonar.count_increases([]).zero?
  end

  def test_handles_one_element_array
    assert Sonar.count_increases([199]).zero?
  end

  def test_handles_arrays_with_nils
    assert Sonar.count_increases(TEST_ARRAY_WITH_NIL) == 6
  end

  def test_count_increases_with_window
    assert Sonar.count_increases_with_window(TEST_ARRAY, 3) == 5
  end

  def test_count_increases_with_window_handles_nil
    assert Sonar.count_increases_with_window(nil, 3).zero?
    assert Sonar.count_increases_with_window(TEST_ARRAY, nil).zero?
  end

  def test_count_increases_with_window_handles_empty_array
    assert Sonar.count_increases_with_window([], 3).zero?
  end

  def test_count_increases_with_window_handles_invalid_window_sizes
    assert Sonar.count_increases_with_window([199], -1).zero?
    assert Sonar.count_increases_with_window([199], 0).zero?
    assert Sonar.count_increases_with_window([199], 1).zero?
    assert Sonar.count_increases_with_window([199], 3).zero?
  end

  def test_count_increases_with_window_handles_arrays_with_nils
    assert Sonar.count_increases_with_window(TEST_ARRAY_WITH_NIL, 3) == 4
  end
end
