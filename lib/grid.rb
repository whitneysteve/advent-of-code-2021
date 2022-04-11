# frozen_string_literal: true

require_relative '../lib/point'

# Class to handle some common grid functions
class Grid
  attr_reader :height, :width

  def initialize(grid)
    raise 'InvalidGrid' if grid.to_a.empty?

    @grid = grid
    @height = @grid.size
    @width = @grid[0]&.size

    validate_grid
  end

  def each_with_index(&block)
    @grid.each_with_index(&block)
  end

  def size
    @height * @width
  end

  def get_value(point)
    raise 'InvalidGridPosition' if !point.is_a?(Point)
    return nil if point.y >= @height || point.x >= @width

    @grid[point.y][point.x]
  end

  def update_value(point, value)
    raise 'InvalidGridPosition' if !point.is_a?(Point) || point.y >= @height || point.x >= @width

    @grid[point.y][point.x] = value
  end

  def get_all_neighbours(point)
    get_non_diagonal_neighbours(point).concat(get_diagonal_neighbours(point))
  end

  # rubocop:disable Metrics/AbcSize
  def get_non_diagonal_neighbours(point)
    neighbours = []
    neighbours << Point.new(point.x, point.y - 1) if point.y.positive?
    neighbours << Point.new(point.x, point.y + 1) if point.y < @height - 1
    neighbours << Point.new(point.x - 1, point.y) if point.x.positive?
    neighbours << Point.new(point.x + 1, point.y) if point.x < @width - 1
    neighbours
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def get_diagonal_neighbours(point)
    neighbours = []
    neighbours << Point.new(point.x - 1, point.y - 1) if point.y.positive? && point.x.positive?
    neighbours << Point.new(point.x + 1, point.y - 1) if point.y.positive? && point.x < @width - 1
    neighbours << Point.new(point.x - 1, point.y + 1) if point.y < @height - 1 && point.x.positive?
    neighbours << Point.new(point.x + 1, point.y + 1) if point.y < @height - 1 && point.x < @width - 1
    neighbours
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def to_s
    s = ''
    @grid.each_with_index do |row, _|
      s += "#{row.inspect}, \n"
    end
    s
  end

  private

  def validate_grid
    @grid.each do |row|
      raise 'InvalidGrid' if !row.is_a?(Array) || row.to_a.empty?
      raise 'NonRectangularGrid' if row.size != @width

      row.each { |value| validate_value(value) }
    end
  end

  def validate_value(value)
    raise 'InvalidGridValue' if value.nil? || !value.is_a?(Integer) || value.negative?
  end
end
