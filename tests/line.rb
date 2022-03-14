# frozen_string_literal: true

require_relative '../lib/line'
require_relative '../lib/point'
require 'minitest/autorun'

# Test for a point to point line.
class LineTest < Minitest::Test
  def test_horizontal
    assert Line.new(Point.new(0, 0), Point.new(5, 0)).horizontal?
    refute Line.new(Point.new(0, 0), Point.new(0, 5)).horizontal?
    refute Line.new(Point.new(0, 0), Point.new(5, 5)).horizontal?
  end

  def test_vertical
    refute Line.new(Point.new(0, 0), Point.new(5, 0)).vertical?
    assert Line.new(Point.new(0, 0), Point.new(0, 5)).vertical?
    refute Line.new(Point.new(0, 0), Point.new(5, 5)).vertical?
  end

  def test_horizontal_or_vertical
    assert Line.new(Point.new(0, 0), Point.new(5, 0)).horizontal_or_vertical?
    assert Line.new(Point.new(0, 0), Point.new(0, 5)).horizontal_or_vertical?
    refute Line.new(Point.new(0, 0), Point.new(5, 5)).horizontal_or_vertical?
  end
end
