# frozen_string_literal: true

# Class to represent a single bingo card in a game of bingo.
class BingoCard
  def initialize(rows)
    raise 'IllegalCard' if rows&.size != 5 || !rows.all? { |row| row.length == 5 }

    @rows = rows
    create_marks(rows)

    raise 'DuplicatesInCard' if @marks.size != 25
  end

  def create_marks(rows)
    @marks = {}
    rows.each_with_index do |row, x|
      row.each_with_index do |value, y|
        @marks[value] = { marked: false, x: x, y: y }
      end
    end
  end

  def mark_and_check(num)
    raise 'InvalidValueToMark' if num.nil?

    card_val = @marks[num]

    unless card_val.nil?
      raise 'AlreadyMarked' if card_val[:marked]

      card_val[:marked] = true

      return column_complete?(card_val) || row_complete?(card_val)
    end

    false
  end

  def unmarked_sum
    @marks.filter_map do |key, val|
      key unless val[:marked]
    end.sum
  end

  private

  def column_complete?(val)
    x = 0
    y = val[:y]

    while x <= 4
      return false unless marked?(x, y)

      x += 1
    end

    true
  end

  def row_complete?(val)
    y = 0
    x = val[:x]

    while y <= 4
      return false unless marked?(x, y)

      y += 1
    end

    true
  end

  # rubocop:disable Naming/MethodParameterName
  def marked?(x, y)
    @marks[@rows[x][y]][:marked]
  end
  # rubocop:enable Naming/MethodParameterName
end
