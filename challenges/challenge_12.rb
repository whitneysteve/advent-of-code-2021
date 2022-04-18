# frozen_string_literal: true

require_relative '../lib/cave_graph'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 12'

  lines = File.readlines('challenges/challenge_12_input')

  graph = CaveGraph.new(lines.map(&:strip))
  puts graph.paths.size
end
