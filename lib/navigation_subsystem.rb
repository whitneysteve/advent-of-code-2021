# frozen_string_literal: true

require 'set'

# The submarines navigation system
class NavigationSubsystem
  OPENERS = Set.new(['[', '(', '<', '{'])

  def initialize(input)
    raise 'InvalidInput' if input.to_a.empty?

    @input = input.map(&:strip).reject(&:empty?)
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

  private

  def corrupt_character(line)
    # puts line
    stack = []
    line.chars.each do |char|
      # puts "#{stack}, #{char}, #{opening?(char)}, #{stack[-1]}, #{mismatch?(stack[-1], char)}"
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

  # rubocop:disable Metrics/CyclomaticComplexity
  def mismatch?(open_char, closing_char)
    (open_char == '[' && closing_char != ']') ||
      (open_char == '(' && closing_char != ')') ||
      (open_char == '<' && closing_char != '>') ||
      (open_char == '{' && closing_char != '}')
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end
