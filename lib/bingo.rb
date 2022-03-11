# frozen_string_literal: true

# Class to represent a game of bingo. It can play a list of numbers across multiple bingo cards and find the order of
# the winning cards.
class Bingo
  def initialize(cards)
    @cards = cards.map { |card| BingoCard.new(card) }
  end

  def play(numbers_called)
    numbers_called.each do |number_called|
      @cards.each do |card_to_check|
        return card_to_check.unmarked_sum * number_called if card_to_check.mark_and_check(number_called)
      end
    end
    0
  end
end
