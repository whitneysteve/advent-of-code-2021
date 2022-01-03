# frozen_string_literal: true

require_relative '../challenges/challenge_1'
require 'minitest/autorun'

# Test for challenge 1.
class SonarTest < Minitest::Test
  def test_counts_increases
    assert Sonar.count_increases([199, 200, 208, 210, 200, 207, 240, 269, 260, 263]) == 7
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
    assert Sonar.count_increases([199, 200, 208, 210, 200, 207, 240, 269, nil, 263]) == 6
  end
end
