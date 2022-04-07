# frozen_string_literal: true

require_relative '../lib/height_map'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 9'

  lines = File.readlines('challenges/challenge_9_input')

  input = []
  lines.each do |line|
    input << line.strip.chars.map(&:to_i)
  end

  map = HeightMap.new(input)
  puts map.low_point_risk_levels
  low_points = map.low_points
  puts low_points.map { |point| map.basin_size(point) }.sort.reverse.take(3).inject(:*)
end
