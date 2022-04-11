# frozen_string_literal: true

require_relative '../lib/grid'
require 'minitest/autorun'

# Test Grid.
class GridTest < Minitest::Test
  TEST_GRID = [
    [2, 1, 9, 9, 9, 4, 3, 2, 1, 0].freeze,
    [3, 9, 8, 7, 8, 9, 4, 9, 2, 1].freeze,
    [9, 8, 5, 6, 7, 8, 9, 8, 9, 2].freeze,
    [8, 7, 6, 7, 8, 9, 6, 7, 8, 9].freeze,
    [9, 8, 9, 9, 9, 6, 5, 6, 7, 8].freeze
  ].freeze

  MUTABLE_GRID_MAP = [
    [2, 1, 9, 9, 9, 4, 3, 2, 1, 0],
    [3, 9, 8, 7, 8, 9, 4, 9, 2, 1],
    [9, 8, 5, 6, 7, 8, 9, 8, 9, 2],
    [8, 7, 6, 7, 8, 9, 6, 7, 8, 9],
    [9, 8, 9, 9, 9, 6, 5, 6, 7, 8]
  ].freeze

  def test_get_value
    grid = Grid.new(TEST_GRID)
    assert_equal 2, grid.get_value(Point.new(0, 0))
    assert_equal 4, grid.get_value(Point.new(5, 0))
    assert_equal 6, grid.get_value(Point.new(5, 4))
  end

  def test_get_value_out_of_bounds
    grid = Grid.new(TEST_GRID)
    assert_nil grid.get_value(Point.new(10, 5))
    assert_nil grid.get_value(Point.new(5, 10))
    assert_nil grid.get_value(Point.new(10, 10))
  end

  def test_update_value
    grid = Grid.new(MUTABLE_GRID_MAP)
    assert_equal 2, grid.get_value(Point.new(0, 0))
    grid.update_value(Point.new(0, 0), 4)
    assert_equal 4, grid.get_value(Point.new(0, 0))
  end

  def test_get_diagonal_neighbours
    grid = Grid.new(TEST_GRID)
    assert_equal [Point.new(2, 2), Point.new(4, 2), Point.new(2, 4), Point.new(4, 4)],
                 grid.get_diagonal_neighbours(Point.new(3, 3))
  end

  def test_update_invalid_positions
    grid = Grid.new(TEST_GRID)
    invalid_inputs = [Point.new(10, 5), Point.new(5, 10), Point.new(10, 10)]
    invalid_inputs.each do |invalid|
      error = assert_raises { grid.update_value(invalid, 99) }
      assert_equal 'InvalidGridPosition', error.message
    end
  end

  def test_get_value_invalid_arg
    grid = Grid.new(TEST_GRID)
    invalid_inputs = [nil, [], '', 1]
    invalid_inputs.each do |invalid|
      error = assert_raises { grid.get_value(invalid) }
      assert_equal 'InvalidGridPosition', error.message
    end
  end

  def test_handles_invalid_input
    invalid_inputs = [nil, [], [''], [' ']]
    invalid_inputs.each do |invalid|
      error = assert_raises { Grid.new(invalid) }
      assert_equal 'InvalidGrid', error.message
    end
  end

  def test_handles_irregular_grid
    invalid_inputs = [[[1], [1, 2]]]
    invalid_inputs.each do |invalid|
      error = assert_raises { Grid.new(invalid) }
      assert_equal 'NonRectangularGrid', error.message
    end
  end
end
