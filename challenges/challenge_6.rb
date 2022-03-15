# frozen_string_literal: true

require_relative '../lib/lantern_fish_population'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 6'

  lines = File.readlines('challenges/challenge_6_input')

  population = LanternFishPopulation.new(lines.first.split(',').map(&:to_i))
  population.pass_days(80)
  puts population.number_of_fish
  population.pass_days(176)
  puts population.number_of_fish
end
