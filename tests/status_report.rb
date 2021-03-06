# frozen_string_literal: true

require_relative '../lib/status_report'
require 'minitest/autorun'

# Test for the sonar module.
class StatusReportTest < Minitest::Test
  TEST_ARRAY = %w[00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010
                  01010].freeze
  TEST_ARRAY_WITH_NIL = ['00100', '11110', '10110', '10111', '10101', '01111', '00111', '11100', '10000', '11001',
                         '00010', nil, '01010'].freeze

  def test_power_consumption
    assert StatusReport.new(TEST_ARRAY).power_consumption == 198
  end

  def test_handles_nil_array
    error = assert_raises { StatusReport.new(nil).power_consumption.zero? }
    assert_equal 'InvalidStatusReport', error.message
  end

  def test_handles_empty_array
    error = assert_raises { StatusReport.new([]).power_consumption.zero? }
    assert_equal 'InvalidStatusReport', error.message
  end

  def test_handles_array_with_nil
    assert StatusReport.new(TEST_ARRAY_WITH_NIL).power_consumption == 198
  end

  def test_life_support
    assert StatusReport.new(TEST_ARRAY).life_support == 230
  end

  def test_life_support_handles_nil_array
    error = assert_raises { StatusReport.new(nil).life_support.zero? }
    assert_equal 'InvalidStatusReport', error.message
  end

  def test_life_support_handles_empty_array
    error = assert_raises { StatusReport.new([]).life_support.zero? }
    assert_equal 'InvalidStatusReport', error.message
  end

  def test_life_support_handles_array_with_nil
    assert StatusReport.new(TEST_ARRAY_WITH_NIL).life_support == 230
  end
end
