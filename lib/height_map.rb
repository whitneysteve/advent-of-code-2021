# frozen_string_literal: true

# Map to chart height of cave systems.
class HeightMap
  def initialize(map)
    raise 'InvalidMap' if map.to_a.empty?

    @map = map
    @height = @map.size
    @width = @map[0]&.size

    validate_map
  end

  def low_points
    @low_points ||= begin
      points = []
      @map.each_with_index do |row, y|
        row.each_with_index do |value, x|
          points << value if low_point?(x, y)
        end
      end
      points
    end
  end

  def low_point_risk_levels
    low_points.sum + low_points.size
  end

  private

  def low_point?(x_coord, y_coord)
    neighbours = []
    neighbours << [x_coord, y_coord - 1] if y_coord.positive?
    neighbours << [x_coord, y_coord + 1] if y_coord < @height - 1
    neighbours << [x_coord - 1, y_coord] if x_coord.positive?
    neighbours << [x_coord + 1, y_coord] if x_coord < @width - 1
    check_neighbours(neighbours, @map[y_coord][x_coord])
  end

  def check_neighbours(neighbours, value)
    neighbours.all? do |neighbour|
      n_x, n_y = neighbour
      @map[n_y][n_x] > value
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
