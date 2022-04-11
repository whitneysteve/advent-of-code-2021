# frozen_string_literal: true

require_relative '../lib/point'
require_relative '../lib/grid'

# Map to chart height of cave systems.
class HeightMap
  attr_reader :grid

  def initialize(map)
    raise 'InvalidMap' if map.to_a.empty?

    @grid = Grid.new(map)
  end

  def low_points
    @low_points ||= begin
      points = []
      @grid.each_with_index do |row, y|
        row.each_with_index do |_value, x|
          point = Point.new(x, y)
          points << point if low_point?(point)
        end
      end
      points
    end
  end

  def low_point_risk_levels
    low_points.map { |point| @grid.get_value(point) }.sum + low_points.size
  end

  # rubocop:disable Metrics/MethodLength
  def basin_size(point)
    visited = []
    queue = []
    curr_value = @grid.get_value(point)
    queue.append(point)

    size = 1

    until queue.empty?
      curr = queue.pop

      get_unvisited_neighbours(curr, visited).each do |neighbour|
        visited << neighbour
        n_value = @grid.get_value(neighbour)

        if n_value > curr_value && n_value < 9
          size += 1
          queue.push(neighbour)
        end
      end
    end

    size
  end
  # rubocop:enable Metrics/MethodLength

  private

  def low_point?(point)
    check_neighbours(@grid.get_non_diagonal_neighbours(point), @grid.get_value(point))
  end

  def get_unvisited_neighbours(point, visited)
    @grid.get_non_diagonal_neighbours(point).reject { |neighbour| visited.include?(neighbour) }
  end

  def check_neighbours(neighbours, value)
    neighbours.all? do |neighbour|
      @grid.get_value(neighbour) > value
    end
  end
end
