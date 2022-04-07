# frozen_string_literal: true

require_relative '../lib/navigation_subsystem'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 10'

  lines = File.readlines('challenges/challenge_10_input')

  navigation = NavigationSubsystem.new(lines)
  puts navigation.corrupted_characters.map { |corrupt_character| navigation.corruption_score(corrupt_character) }.sum

  navigation = NavigationSubsystem.new(lines, filter_corrupt: true)
  auto_complete_lines = navigation.auto_complete_input
  auto_complete_scores = auto_complete_lines.map { |line| navigation.auto_complete_line_score(line) }.sort
  puts auto_complete_scores[(auto_complete_scores.size - 1) / 2]
end
