# frozen_string_literal: true

require_relative '../lib/flashing_octopus'
require 'minitest/autorun'

# Test for crab alignment.
class FlashingOctopusTest < Minitest::Test
  def test_count_flashes
    octopodes = FlashingOctopus.new(test_octopodes)
    octopodes.progress(10)
    assert_equal 204, octopodes.flash_count
    octopodes.progress(90)
    assert_equal 1656, octopodes.flash_count
  end

  def test_synchronised_flashes
    octopodes = FlashingOctopus.new(test_octopodes)
    octopodes.progress(195)
    assert_equal [195], octopodes.synchronised_flashes
  end

  def test_handles_invalid_input
    invalid_inputs = [nil, [], [''], [' ']]
    invalid_inputs.each do |invalid|
      error = assert_raises { FlashingOctopus.new(invalid) }
      assert_equal 'InvalidGrid', error.message
    end
  end

  def test_handles_irregular_grid
    invalid_inputs = [[[1], [1, 2]]]
    invalid_inputs.each do |invalid|
      error = assert_raises { FlashingOctopus.new(invalid) }
      assert_equal 'NonRectangularGrid', error.message
    end
  end

  private

  # rubocop:disable Metrics/MethodLength
  def test_octopodes
    [
      [5, 4, 8, 3, 1, 4, 3, 2, 2, 3],
      [2, 7, 4, 5, 8, 5, 4, 7, 1, 1],
      [5, 2, 6, 4, 5, 5, 6, 1, 7, 3],
      [6, 1, 4, 1, 3, 3, 6, 1, 4, 6],
      [6, 3, 5, 7, 3, 8, 5, 4, 7, 8],
      [4, 1, 6, 7, 5, 2, 4, 6, 4, 5],
      [2, 1, 7, 6, 8, 4, 1, 7, 2, 1],
      [6, 8, 8, 2, 8, 8, 1, 1, 3, 4],
      [4, 8, 4, 6, 8, 4, 8, 5, 5, 4],
      [5, 2, 8, 3, 7, 5, 1, 5, 2, 6]
    ].freeze
  end
  # rubocop:enable Metrics/MethodLength
end
