# frozen_string_literal: true

# Class to represent submarine seven segment display.
#
# Cascading translation table:
# 1 = 2 characters
# 4 = 4 characters
# 7 = 3 characters
# 8 = 7 characters
# 3 = 5 characters and overlaps with 1
# 9 = 6 characters and overlaps with 4
# 0 = 6 characters, overlaps with one, not nine
# 6 = 6 characters, does not overlap with one, not nine
# 5 = 5 characters, 6 overlaps with 5, not three
# 2 = 5 characters, 6 does not overlap with 2, not three
class SevenSegmentDisplay
  # Create a new seven segment display, based on the read signals and display.
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def initialize(inputs)
    validate_input(inputs)

    patterns, digit_signals = inputs.split('|').map(&:strip)
    patterns = patterns.split.map { |pattern| memoize(pattern.strip) }
    validate_patterns(patterns)

    @digit_signals = digit_signals.split.map(&:strip)
    valdiate_digit_signals

    one = find_digits_with_length(patterns, 2).first
    four = find_digits_with_length(patterns, 4).first
    seven = find_digits_with_length(patterns, 3).first
    eight = find_digits_with_length(patterns, 7).first

    three = find_digit_with_length_and_pattern(patterns, 5, one).first
    nine = find_digit_with_length_and_pattern(patterns, 6, four).first

    zero, six = find_digits_excluding_segment(patterns, 6, nine, one)
    five, two = find_digits_excluding_segment(patterns, 5, three, six, invert: true)

    @patterns = {
      zero => 0,
      one => 1,
      two => 2,
      three => 3,
      four => 4,
      five => 5,
      six => 6,
      seven => 7,
      eight => 8,
      nine => 9
    }
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  # Get the digits that the display _should_ be displaying, based on the interrogation of the wire signals.
  def digits
    @digits ||= begin
      digits = []
      @digit_signals.each do |pattern|
        translated = translate_digit(pattern)
        (digits << translated) || -1
      end
      digits
    end
  end

  # For a given pattern currently displaying for a digit on the display, get the actual value it should be displaying.
  def translate_digit(pattern)
    @patterns[memoize(pattern)]
  end

  private

  def find_digits_with_length(patterns, length)
    patterns.select { |pattern| pattern.strip.size == length }
  end

  def find_digit_with_length_and_pattern(patterns, length, pattern_to_find)
    find_digits_with_length(patterns, length).select do |pattern|
      digit_has_all_segments_from(pattern_to_find, pattern)
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/PerceivedComplexity
  def find_digits_excluding_segment(patterns, length, cont, exclude, invert: false)
    incl = ''
    excl = ''
    find_digits_with_length(patterns, length).each do |pattern|
      next if pattern == cont

      if (invert && pattern.chars.all? { |char| exclude.include? char }) || exclude.chars.all? do |char|
           pattern.include? char
         end
        incl = pattern
      else
        excl = pattern
      end
    end
    [incl, excl]
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity

  def digit_has_all_segments_from(digit, from)
    digit.chars.all? { |char| from.include? char }
  end

  def memoize(pattern)
    pattern.downcase.chars.sort!.join
  end

  def validate_input(input)
    raise 'InvalidInput' if input.nil? || input.strip.empty?
    raise 'NoDelimiter' unless input.include? '|'
  end

  def validate_patterns(patterns)
    raise 'InvalidPatterns' if patterns.size != 10

    patterns.each { |pattern| raise 'InvalidPattern' unless valid?(pattern) }
  end

  def valdiate_digit_signals
    raise 'InvalidSignals' if @digit_signals.size != 4

    @digit_signals.each { |digit_signal| raise 'InvalidPattern' unless valid?(digit_signal) }
  end

  def valid?(pattern)
    return false if pattern.nil? || pattern.strip.empty?

    pattern.match(/^[a-g]{0,7}$/i) && pattern.chars.uniq.size == pattern.size
  end
end
