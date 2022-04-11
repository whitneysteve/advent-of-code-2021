# frozen_string_literal: true

require_relative '../lib/flashing_octopus'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 11'

  lines = File.readlines('challenges/challenge_11_input')

  octopodes = FlashingOctopus.new(lines.map { |line| line.strip.chars.map(&:to_i) })
  octopodes.progress(100)
  puts octopodes.flash_count
end
