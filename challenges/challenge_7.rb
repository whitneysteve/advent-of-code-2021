# frozen_string_literal: true

require_relative '../lib/crab_alignment'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 7'

  lines = File.readlines('challenges/challenge_7_input')

  alignment = CrabAlignment.new(lines[0].split(',').map(&:to_i))
  puts alignment.fuel_cost_for_position(alignment.cheapest_horizontal_alignment_position,
                                        linear_fuel_consumption: false)
  puts alignment.cheapest_fuel_cost_to_align_with_non_linear_fuel_usage
end
