# frozen_string_literal: true

require 'set'

# The submarines navigation system
# rubocop:disable Metrics/ClassLength
class NavigationSubsystem
  OPENERS = Set.new(['[', '(', '<', '{'])

  CLOSERS = {
    '[' => ']',
    '(' => ')',
    '<' => '>',
    '{' => '}'
  }.freeze

  def initialize(input, filter_corrupt: false)
    raise 'InvalidInput' if input.to_a.empty?

    @input = input.map(&:strip).reject do |line|
      line.strip.empty? || (filter_corrupt && corrupt?(line))
    end
    raise 'InvalidInput' if @input.to_a.empty?
  end

  # Returns the corrupted characters in the subsystem input.
  def corrupted_characters
    @corrupted_characters ||= begin
      corrupt_characters = []
      @input.each do |line|
        corrupt_character = corrupt_character(line)
        corrupt_characters << corrupt_character unless corrupt_character.nil?
      end
      corrupt_characters
    end
  end

  # Get the corruption score of a character.
  # rubocop:disable Metrics/MethodLength
  def corruption_score(corrupt_character)
    raise 'InvalidInput' if corrupt_character.nil? || corrupt_character.strip.empty?

    case corrupt_character
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
  end
  # rubocop:enable Metrics/MethodLength

  # Returns the auto-completed input added to each non-corrupt input line
  def auto_complete_input
    @auto_complete_input ||= @input.map { |line| auto_complete_line(line) }
  end

  # Get the corruption score of a line of added syntax.
  def auto_complete_line_score(line)
    raise 'InvalidInput' if line.nil? || line.strip.empty?

    sum = 0
    line.chars.each do |completed_character|
      sum *= 5
      sum += auto_complete_score(completed_character)
    end
    sum
  end

  private

  def corrupt?(line)
    !corrupt_character(line).nil?
  end

  def auto_complete_line(line)
    stack = []
    line.chars.each do |char|
      opener = opening?(char)
      stack << char if opener
      stack.pop unless opener
    end

    new_line = ''
    new_line = "#{new_line}#{closing_char_for(stack.pop)}" until stack.empty?
    new_line
  end

  # rubocop:disable Metrics/MethodLength
  def auto_complete_score(completed_character)
    case completed_character
    when ')'
      1
    when ']'
      2
    when '}'
      3
    when '>'
      4
    else
      raise "InvalidChar: #{completed_character}"
    end
  end
  # rubocop:enable Metrics/MethodLength

  def corrupt_character(line)
    stack = []
    line.chars.each do |char|
      if opening?(char)
        stack << char
      else
        last_opener = stack.pop
        return char if mismatch?(last_opener, char)
      end
    end
    nil
  end

  def opening?(char)
    OPENERS.include?(char)
  end

  def mismatch?(open_char, closing_char)
    closing_char != closing_char_for(open_char)
  end

  def closing_char_for(open_char)
    CLOSERS[open_char]
  end
end
# rubocop:enable Metrics/ClassLength
