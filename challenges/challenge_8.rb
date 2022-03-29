# frozen_string_literal: true

require_relative '../lib/seven_segment_display'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 8'

  lines = File.readlines('challenges/challenge_8_input')

  counts = 0
  lines.each do |line|
    digits = SevenSegmentDisplay.new(line).digits
    counts += digits.count { |digit| [1, 4, 7, 8].include?(digit) }
  end
  puts counts
end
