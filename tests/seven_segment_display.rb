# frozen_string_literal: true

require_relative '../lib/seven_segment_display'
require 'minitest/autorun'

# Test for the submarine seven segment display.
class SevenSegmentDisplayTest < Minitest::Test
  TEST_STR = 'be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe'

  def test_deciphers_signal_patterns
    display = SevenSegmentDisplay.new(TEST_STR)
    assert_equal 1, display.translate_digit('eb')
    assert_equal 4, display.translate_digit('gcbe')
    assert_equal 7, display.translate_digit('bed')
    assert_equal 8, display.translate_digit('cfbegad')
  end

  def test_deciphers_out_of_order_signal_patterns
    display = SevenSegmentDisplay.new(TEST_STR)
    assert_equal 1, display.translate_digit('be')
    assert_equal 4, display.translate_digit('bceg')
    assert_equal 7, display.translate_digit('bde')
    assert_equal 8, display.translate_digit('abcdefg')
  end

  def test_deciphers_simple_digits
    display = SevenSegmentDisplay.new(
      'be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | eb begc deb dfbegac'
    )
    assert_equal [1, 4, 7, 8], display.digits
  end

  def test_deciphers_inferred_digits
    display = SevenSegmentDisplay.new(
      'acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cagedb gcdfa fbcad cdfbe'
    )
    assert_equal [0, 2, 3, 5], display.digits
    display = SevenSegmentDisplay.new(
      'acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfgeb cefabd cagedb cagedb'
    )
    assert_equal [6, 9, 0, 0], display.digits
  end

  def test_handles_invalid_input
    invalid_inputs = [nil, '', ' ']
    invalid_inputs.each do |invalid|
      error = assert_raises { SevenSegmentDisplay.new(invalid) }
      assert_equal 'InvalidInput', error.message
    end
  end

  def test_handles_no_delimiter
    error = assert_raises do
      SevenSegmentDisplay.new('be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb : fdgacbe cefdb cefbgd gcbe')
    end
    assert_equal 'NoDelimiter', error.message
  end

  def test_handles_extra_pattern
    error = assert_raises do
      SevenSegmentDisplay.new(
        'be eb cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe'
      )
    end
    assert_equal 'InvalidPatterns', error.message
  end

  def test_handles_less_patterns
    error = assert_raises do
      SevenSegmentDisplay.new('cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe')
    end
    assert_equal 'InvalidPatterns', error.message
  end

  def test_handles_invalid_pattern
    invalid_patterns = %w[ebb x y z]

    invalid_patterns.each do |invalid|
      error = assert_raises do
        SevenSegmentDisplay.new(
          "#{invalid} cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe"
        )
      end
      assert_equal 'InvalidPattern', error.message
    end
  end

  def test_handles_extra_signal
    error = assert_raises do
      SevenSegmentDisplay.new(
        'be eb cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe be'
      )
    end
    assert_equal 'InvalidPatterns', error.message
  end

  def test_handles_less_signal
    error = assert_raises do
      SevenSegmentDisplay.new('cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe be')
    end
    assert_equal 'InvalidPatterns', error.message
  end

  def test_handles_invalid_signal
    invalid_signals = %w[ebb x y z]

    invalid_signals.each do |invalid|
      error = assert_raises do
        SevenSegmentDisplay.new(
          "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd #{invalid}"
        )
      end
      assert_equal 'InvalidPattern', error.message
    end
  end
end
