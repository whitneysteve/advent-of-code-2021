# frozen_string_literal: true

require_relative '../lib/navigation_subsystem'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 10'

  lines = File.readlines('challenges/challenge_10_input')

  navigation = NavigationSubsystem.new(lines)
  puts navigation.corrupted_characters.map { |x|
    case x
    when ')'
      3
    when ']'
      57
    when '}'
      1197
    when '>'
      25_137
    else
      raise "InvalidChar: #{corrupt_character}"
    end
  }.sum
end
