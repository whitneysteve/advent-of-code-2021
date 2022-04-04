# frozen_string_literal: true

require_relative '../lib/height_map'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 9'

  lines = File.readlines('challenges/challenge_9_input')

  input = []
  lines.each do |line|
    input << line.strip.split('').map(&:to_i)
  end

  map = HeightMap.new(input)
  puts map.low_point_risk_levels
end
