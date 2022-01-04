# frozen_string_literal: true

require_relative '../lib/sonar'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 1'

  readings = File.readlines('challenges/challenge_1_input').map(&:to_i)
  puts Sonar.count_increases(readings)
  puts Sonar.count_increases_with_window(readings, 3)
end
