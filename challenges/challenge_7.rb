# frozen_string_literal: true

require_relative '../lib/crab_alignment'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 7'

  lines = File.readlines('challenges/challenge_7_input')

  alignment = CrabAlignment.new(lines[0].split(',').map(&:to_i))
  puts alignment.fuel_cost_for_position(alignment.cheapest_horizontal_alignment_position)
end
