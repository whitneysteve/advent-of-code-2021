# frozen_string_literal: true

# A very simple representation of a geometric point. Currently only a 2D point.
class Point
  attr_reader :x, :y

  # rubocop:disable Naming/MethodParameterName
  def initialize(x, y)
    @x = x
    @y = y
  end
  # rubocop:enable Naming/MethodParameterName
end
