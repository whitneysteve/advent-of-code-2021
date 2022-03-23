# frozen_string_literal: true

require_relative '../lib/crab_alignment'
require 'minitest/autorun'

# Test for crab alignment.
class CrabAlignmentTest < Minitest::Test
  TEST_POSITIONS = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14].freeze

  def test_cheapest_horizontal_alignment_position
    alignment = CrabAlignment.new(TEST_POSITIONS)
    assert_equal 2, alignment.cheapest_horizontal_alignment_position
    alignment = CrabAlignment.new([16, 1, 2, 0, 4, 2, nil, 7, 1, 2, 14])
    assert_equal 2, alignment.cheapest_horizontal_alignment_position
  end

  def test_fuel_cost_for_position
    alignment = CrabAlignment.new(TEST_POSITIONS)
    assert_equal 41, alignment.fuel_cost_for_position(1)
    assert_equal 37, alignment.fuel_cost_for_position(2)
    assert_equal 39, alignment.fuel_cost_for_position(3)
    assert_equal 71, alignment.fuel_cost_for_position(10)
  end

  def test_raises_error_for_no_crabs
    error = assert_raises { CrabAlignment.new([]) }
    assert_equal 'InvalidCrabs', error.message
  end

  def test_raises_error_for_nil_crabs
    error = assert_raises { CrabAlignment.new(nil) }
    assert_equal 'InvalidCrabs', error.message
  end
end
