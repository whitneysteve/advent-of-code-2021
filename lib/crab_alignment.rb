# frozen_string_literal: true

# Class to help align the crabs on a goal.
class CrabAlignment
  def initialize(positions)
    raise 'InvalidCrabs' if positions.to_a.empty?

    @positions = positions.compact.sort
  end

  def cheapest_horizontal_alignment_position
    even = @positions.size.even?
    mid = (@positions.size / 2).floor

    if even
      ((@positions[mid - 1] + @positions[mid]) / 2).floor
    else
      positions.sort[mid]
    end
  end

  def fuel_cost_for_position(position)
    @positions.sum { |current_position| (current_position - position).abs }
  end
end
