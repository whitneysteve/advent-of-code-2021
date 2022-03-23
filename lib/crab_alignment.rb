# frozen_string_literal: true

# Class to help align the crabs on a goal.
class CrabAlignment
  FIXNUM_MAX = (2**(0.size * 8 - 2) - 1)

  def initialize(positions)
    raise 'InvalidCrabs' if positions.to_a.empty?

    @positions = positions.compact.sort
    @max = @positions[-1]
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

  def cheapest_fuel_cost_to_align_with_non_linear_fuel_usage
    min_cost = FIXNUM_MAX
    (0..(@max - 1)).each_with_index do |position, _idx|
      cost = fuel_cost_for_position(position, linear_fuel_consumption: false)
      min_cost = cost if cost < min_cost
    end
    min_cost
  end

  def fuel_cost_for_position(position, linear_fuel_consumption: true)
    if linear_fuel_consumption
      @positions.sum { |current_position| (current_position - position).abs }
    else
      @positions.sum do |current_position|
        distance = (current_position - position).abs
        ((distance * (distance + 1)) / 2).floor
      end
    end
  end
end
