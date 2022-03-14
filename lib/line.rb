# frozen_string_literal: true

# Representation of a line between two points.
class Line
  attr_reader :start, :finish

  def initialize(start, finish)
    @start = start
    @finish = finish
  end

  def horizontal_or_vertical?
    horizontal? || vertical?
  end

  def horizontal?
    @start.y == @finish.y
  end

  def vertical?
    @start.x == @finish.x
  end
end
