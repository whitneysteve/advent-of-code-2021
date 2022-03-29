# frozen_string_literal: true

# Class to represent submarine seven segment display.
# Translation table:
# 1 = 2 characters - cf
# 4 = 4 characters - bcdf
# 7 = 3 characters - acf
# 8 = 7 characters - abcdefg
#
# Segment a = characters in 7 - characters in 1
#
# 0 = 6 - abcefg
# 2 = 5 - acdeg
# 3 = 5 - acdfg
# 5 = 5 - abdfg
# 6 = 6 - abdefg
# 9 = 6 - abcdfg
#
class SevenSegmentDisplay
  def initialize(inputs)
    validate_input(inputs)

    patterns, digit_signals = inputs.split('|').map(&:strip)
    validate_patterns(patterns)

    @digit_signals = digit_signals.split.map(&:strip)
    valdiate_digit_signals
  end

  def digits
    @digits ||= begin
      digits = []
      @digit_signals.each do |pattern|
        translated = translate_digit(pattern)
        digits << translated || -1
      end
      digits
    end
  end

  def translate_digit(pattern)
    if pattern.size == 2
      1
    elsif pattern.strip.size == 4
      4
    elsif pattern.strip.size == 3
      7
    elsif pattern.strip.size == 7
      8
    end
  end

  private

  def validate_input(input)
    raise 'InvalidInput' if input.nil? || input.strip.empty?
    raise 'NoDelimiter' unless input.include? '|'
  end

  def validate_patterns(patterns)
    indiv_patterns = patterns.split(' ').map(&:strip)
    raise 'InvalidPatterns' if indiv_patterns.size != 10

    indiv_patterns.each { |pattern| raise 'InvalidPattern' unless valid?(pattern) }
  end

  def valdiate_digit_signals
    raise 'InvalidSignals' if @digit_signals.size != 4

    @digit_signals.each { |digit_signal| raise 'InvalidPattern' unless valid?(digit_signal) }
  end

  def memoize(pattern)
    pattern.downcase.chars.sort!.join
  end

  def valid?(pattern)
    return false if pattern.nil? || pattern.strip.empty?

    pattern.match(/^[a-g]{0,7}$/i) && pattern.chars.uniq.size == pattern.size
  end
end
