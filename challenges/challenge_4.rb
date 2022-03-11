# frozen_string_literal: true

require_relative '../lib/bingo'
require_relative '../lib/bingo_card'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 4'

  report_data = File.readlines('challenges/challenge_4_input')
  numbers_called = report_data[0].split(',').map(&:to_i)

  bingo_cards = []
  card_arr = []
  report_data[2..].each do |next_line|
    if next_line&.strip&.empty?
      bingo_cards << card_arr.dup
      card_arr = []
    else
      card_arr << next_line.split(' ').map(&:to_i)
    end
  end

  winners = Bingo.new(bingo_cards).calculate_winners_and_score(numbers_called)
  puts winners[0][:score]
  puts winners[-1][:score]

end
