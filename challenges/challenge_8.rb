# frozen_string_literal: true

require_relative '../lib/seven_segment_display'

def num_from_array(arr)
  result = 0
  arr.each do |val|
    result = (result * 10) + val
  end
  result
end

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 8'

  lines = File.readlines('challenges/challenge_8_input')

  counts1478 = 0
  total = 0
  lines.each do |line|
    digits = SevenSegmentDisplay.new(line).digits
    counts1478 += digits.count { |digit| [1, 4, 7, 8].include?(digit) }
    total += num_from_array(digits)
  end
  puts counts1478
  puts total
end
