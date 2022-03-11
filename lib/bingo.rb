# frozen_string_literal: true

# Class to represent a game of bingo. It can play a list of numbers across multiple bingo cards and find the order of
# the winning cards.
class Bingo
  def initialize(cards)
    @cards = cards.map { |card| BingoCard.new(card) }
  end

  def calculate_winners_and_score(numbers_called)
    winners = []
    numbers_called.each do |number_called|
      keep_playing = @cards.filter do |card_to_check|
        winner = card_to_check.mark_and_check(number_called)
        winners << { card: card_to_check, score: card_to_check.unmarked_sum * number_called } if winner
        !winner
      end
      @cards = keep_playing
    end
    winners
  end
end
