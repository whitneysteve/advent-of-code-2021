# frozen_string_literal: true

require_relative '../lib/point'

# Map to chart height of cave systems.
class HeightMap
  def initialize(map)
    raise 'InvalidMap' if map.to_a.empty?

    @map = map
    @height = @map.size
    @width = @map[0]&.size

    validate_map
  end

  def get_value(point)
    @map[point.y][point.x]
  end

  def low_points
    @low_points ||= begin
      points = []
      @map.each_with_index do |row, y|
        row.each_with_index do |_value, x|
          point = Point.new(x, y)
          points << point if low_point?(point)
        end
      end
      points
    end
  end

  def low_point_risk_levels
    low_points.map { |point| get_value(point) }.sum + low_points.size
  end

  # rubocop:disable Metrics/MethodLength
  def basin_size(point)
    visited = []
    queue = []
    curr_value = get_value(point)
    queue.append(point)

    size = 1

    until queue.empty?
      curr = queue.pop

      get_unvisited_neighbours(curr, visited).each do |neighbour|
        visited << neighbour
        n_value = get_value(neighbour)

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
    check_neighbours(get_neighbours(point), get_value(point))
  end

  # rubocop:disable Metrics/AbcSize
  def get_neighbours(point)
    neighbours = []
    neighbours << Point.new(point.x, point.y - 1) if point.y.positive?
    neighbours << Point.new(point.x, point.y + 1) if point.y < @height - 1
    neighbours << Point.new(point.x - 1, point.y) if point.x.positive?
    neighbours << Point.new(point.x + 1, point.y) if point.x < @width - 1
    neighbours
  end
  # rubocop:enable Metrics/AbcSize

  def get_unvisited_neighbours(point, visited)
    get_neighbours(point).reject { |neighbour| visited.include?(neighbour) }
  end

  def check_neighbours(neighbours, value)
    neighbours.all? do |neighbour|
      get_value(neighbour) > value
    end
  end

  def validate_map
    @map.each do |row|
      raise 'InvalidMap' if row.to_a.empty?
      raise 'NonRectangularMap' if row.size != @width

      row.each { |value| validate_value(value) }
    end
  end

  def validate_value(value)
    raise 'InvalidMapValue' if value.nil? || !value.is_a?(Integer) || value.negative?
  end
end
