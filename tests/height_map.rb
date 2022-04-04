# frozen_string_literal: true

require_relative '../lib/height_map'
require 'minitest/autorun'

# Test for cave height maps.
class HaightMapTest < Minitest::Test
  TEST_MAP = [
    [2, 1, 9, 9, 9, 4, 3, 2, 1, 0],
    [3, 9, 8, 7, 8, 9, 4, 9, 2, 1],
    [9, 8, 5, 6, 7, 8, 9, 8, 9, 2],
    [8, 7, 6, 7, 8, 9, 6, 7, 8, 9],
    [9, 8, 9, 9, 9, 6, 5, 6, 7, 8]
  ].freeze

  MUTABLE_TEST_MAP = [
    [1, 2, 3],
    [1, 2, 3],
    [1, 2, 3]
  ].freeze

  def test_low_points
    map = HeightMap.new(TEST_MAP)
    assert_equal [1, 0, 5, 5], map.low_points
  end

  def test_low_point_risk_levels
    map = HeightMap.new(TEST_MAP)
    assert_equal 15, map.low_point_risk_levels
  end

  def test_invalid_map
    invalid = [nil, []]
    invalid.each do |_invalid_map|
      error = assert_raises { HeightMap.new(invalid) }
      assert_equal 'InvalidMap', error.message
    end
  end

  def test_rectangular_map
    error = assert_raises { HeightMap.new([[1, 2], [1, 2, 3]]) }
    assert_equal 'NonRectangularMap', error.message
  end

  def test_invalid_value
    invalid_values = ['', nil, -1]
    invalid_values.each do |invalid|
      MUTABLE_TEST_MAP[1][1] = invalid
      error = assert_raises { HeightMap.new(MUTABLE_TEST_MAP) }
      assert_equal 'InvalidMapValue', error.message
    end
  end
end
