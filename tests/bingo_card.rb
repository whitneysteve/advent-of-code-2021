# frozen_string_literal: true

require_relative '../lib/bingo_card'
require 'minitest/autorun'

# Test for bingo card.
class BingoCardTest < Minitest::Test
  TEST_ROW_1 = [22, 13, 17, 11, 0].freeze
  TEST_ROW_2 = [8, 2, 23, 4, 24].freeze
  TEST_ROW_3 = [21, 9, 14, 16, 7].freeze
  TEST_ROW_4 = [6, 10, 3, 18, 5].freeze
  TEST_CARD = [
    TEST_ROW_1,
    TEST_ROW_2,
    TEST_ROW_3,
    TEST_ROW_4,
    [1, 12, 20, 15, 19]
  ].freeze

  TEST_CARD_2 = [
    [3,  15, 0,  2,  22],
    [9,  18, 13, 17, 5],
    [19,  8, 7,  25, 23],
    [20, 11, 10, 24, 4],
    [14, 21, 16, 12, 6]
  ].freeze

  def test_should_create_card
    BingoCard.new(TEST_CARD)
  end

  def test_should_mark_column_as_complete
    card = BingoCard.new(TEST_CARD)
    assert_complete(card, [22, 8, 21, 6, 1])
  end

  def test_should_mark_row_as_complete
    card = BingoCard.new(TEST_CARD)
    assert_complete(card, [8, 2, 23, 4, 24])
  end

  def test_should_not_mark_as_complete
    card = BingoCard.new(TEST_CARD_2)
    refute card.mark_and_check(7)
    refute card.mark_and_check(4)
    refute card.mark_and_check(9)
    refute card.mark_and_check(5)
    refute card.mark_and_check(11)
    refute card.mark_and_check(17)
    refute card.mark_and_check(23)
  end

  def test_unmarked_sum
    card = BingoCard.new(TEST_CARD)
    complete_row(card, TEST_CARD)
    assert card.unmarked_sum == 237
  end

  def test_should_raise_error_for_null_rows
    error = assert_raises { BingoCard.new(nil) }
    assert_equal 'IllegalCard', error.message
  end

  def test_should_raise_error_for_null_row
    error = assert_raises { BingoCard.new([nil]) }
    assert_equal 'IllegalCard', error.message
  end

  def test_should_raise_error_for_irregular_card
    card1 = [[1, 2], [3, 4, 5]]
    card2 = [[1, 2], [3, 4], [5, 6]]
    [card1, card2].each do |card|
      error = assert_raises { BingoCard.new(card) }
      assert_equal 'IllegalCard', error.message
    end
  end

  def test_should_raise_error_for_card_with_duplicates
    error = assert_raises do
      BingoCard.new([
                      TEST_ROW_1,
                      TEST_ROW_2,
                      TEST_ROW_3,
                      TEST_ROW_4,
                      TEST_ROW_4
                    ])
    end
    assert_equal 'DuplicatesInCard', error.message
  end

  def test_should_raise_error_for_marking_marked_number
    card = BingoCard.new(TEST_CARD)
    refute card.mark_and_check(22)
    error = assert_raises { card.mark_and_check(22) }
    assert_equal 'AlreadyMarked', error.message
  end

  def test_should_raise_error_for_marking_nil
    card = BingoCard.new(TEST_CARD)
    error = assert_raises { card.mark_and_check(nil) }
    assert_equal 'InvalidValueToMark', error.message
  end

  private

  def complete_row(card, data)
    data[0][0..3].each { |value| refute card.mark_and_check(value) }
    assert card.mark_and_check(data[0][4])
  end

  def assert_complete(card, numbers_called)
    numbers_called.take(4).each { |number| refute card.mark_and_check(number) }
    assert card.mark_and_check(numbers_called[-1])
  end
end
