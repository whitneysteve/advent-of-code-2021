# frozen_string_literal: true

require_relative '../lib/line'
require_relative '../lib/point'
require_relative '../lib/vent_map'

def parse_point(point_str)
  x, y = point_str.split(',')
  Point.new(x.to_i, y.to_i)
end

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 4'

  lines = File.readlines('challenges/challenge_5_input')
  parsed_lines = lines.map do |line|
    start, finish = line.split(' -> ')
    Line.new(parse_point(start), parse_point(finish))
  end

  map = VentMap.new(parsed_lines)
  puts map.count_dangerous_points(2)
end
