# frozen_string_literal: true

require_relative '../lib/bingo'
require 'minitest/autorun'

# Test for bingo game runner.
class BingoTest < Minitest::Test
  TEST_CARD_1 = [
    [22, 13, 17, 11, 0],
    [8, 2, 23, 4, 24],
    [21, 9, 14, 16, 7],
    [6, 10, 3, 18, 5],
    [1, 12, 20, 15, 19]
  ].freeze

  TEST_CARD_2 = [
    [3,  15, 0,  2,  22],
    [9,  18, 13, 17, 5],
    [19,  8, 7,  25, 23],
    [20, 11, 10, 24, 4],
    [14, 21, 16, 12, 6]
  ].freeze

  TEST_CARD_3 = [
    [14, 21, 17, 24, 4],
    [10, 16, 15, 9, 19],
    [18, 8, 23, 26, 20],
    [22, 11, 13, 6, 5],
    [2, 0, 12, 3, 7]
  ].freeze

  NUMBERS_CALLED = [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24, 10, 16, 13, 6, 15, 25, 12, 22, 18, 20, 8, 19, 3, 26,
                    1].freeze

  def test_find_correct_score
    assert_equal 4512, Bingo.new([TEST_CARD_1, TEST_CARD_2, TEST_CARD_3]).play(NUMBERS_CALLED)
  end

  def test_find_zero_score_if_no_winner
    assert_equal 0, Bingo.new([TEST_CARD_1, TEST_CARD_2, TEST_CARD_3]).play([7])
  end
end
