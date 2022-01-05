# frozen_string_literal: true

# Class to parse and store submarine course commands
class CourseCommand
  VALID_DIRECTIONS = %w[
    down
    forward
    up
  ].freeze

  attr_reader :distance

  def self.parse(command_str)
    direction, distance, remainder = command_str&.split(' ')
    return nil if remainder

    direction = direction&.downcase
    return nil unless VALID_DIRECTIONS.include?(direction)

    distance = distance.to_i
    return nil if distance < 1

    CourseCommand.new(direction, sign_for_distance(direction, distance))
  end

  def initialize(direction, distance)
    @direction = direction
    @distance = distance
  end

  def horizontal?
    @horizontal ||= @direction == 'forward'
  end

  def depth?
    @depth || @direction == 'up' || @direction == 'down'
  end

  def self.sign_for_distance(direction, distance)
    if direction == 'up'
      -distance
    else
      distance
    end
  end
end
