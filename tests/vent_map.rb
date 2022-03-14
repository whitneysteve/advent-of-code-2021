# frozen_string_literal: true

require_relative '../lib/line'
require_relative '../lib/point'
require_relative '../lib/vent_map'
require 'minitest/autorun'

# Test for the map that tracks vent lines.
class VentMapTest < Minitest::Test
  TEST_MAP = VentMap.new([
                           Line.new(Point.new(0, 9), Point.new(5, 9)),
                           Line.new(Point.new(8, 0), Point.new(0, 8)),
                           Line.new(Point.new(9, 4), Point.new(3, 4)),
                           Line.new(Point.new(2, 2), Point.new(2, 1)),
                           Line.new(Point.new(7, 0), Point.new(7, 4)),
                           Line.new(Point.new(6, 4), Point.new(2, 0)),
                           Line.new(Point.new(0, 9), Point.new(2, 9)),
                           Line.new(Point.new(3, 4), Point.new(1, 4)),
                           Line.new(Point.new(0, 0), Point.new(8, 8)),
                           Line.new(Point.new(5, 5), Point.new(8, 2))
                         ])

  EXPECTED_TO_S = ".......1..
..1....1..
..1....1..
.......1..
.112111211
..........
..........
..........
..........
222111....
"

  def test_count_danger_points
    assert_equal 5, TEST_MAP.count_dangerous_points(2)
  end

  def test_to_s
    assert_equal EXPECTED_TO_S, TEST_MAP.to_s
  end
end
