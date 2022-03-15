# frozen_string_literal: true

require_relative '../lib/lantern_fish_population'
require 'minitest/autorun'

# Test lantern fish population simulation.
class LineTest < Minitest::Test
  # rubocop:disable Metrics/AbcSize
  def test_should_initialise
    pop = LanternFishPopulation.new([3, 4, 3, 1, 2])
    assert_equal [0, 1, 1, 2, 1, 0, 0, 0, 0],
                 [pop.buckets[0], pop.buckets[1], pop.buckets[2], pop.buckets[3], pop.buckets[4], pop.buckets[5],
                  pop.buckets[6], pop.buckets[7], pop.buckets[8]]
  end

  def test_should_initialise_with_new
    pop = LanternFishPopulation.new([3, 4, 3, 1, 2, 7, 8])
    assert_equal 1, pop.buckets[7]
    assert_equal 1, pop.buckets[8]
  end

  def test_should_move_one_cycle
    pop = LanternFishPopulation.new([3, 4, 3, 1, 2, 7, 8])
    pop.pass_days(1)
    assert_equal [1, 1, 2, 1, 0, 0, 1, 1, 0],
                 [pop.buckets[0], pop.buckets[1], pop.buckets[2], pop.buckets[3], pop.buckets[4], pop.buckets[5],
                  pop.buckets[6], pop.buckets[7], pop.buckets[8]]
  end

  def test_should_move_more_cycles
    pop = LanternFishPopulation.new([3, 4, 3, 1, 2])
    pop.pass_days(18)
    assert_equal [3, 5, 3, 2, 2, 1, 5, 1, 4],
                 [pop.buckets[0], pop.buckets[1], pop.buckets[2], pop.buckets[3], pop.buckets[4], pop.buckets[5],
                  pop.buckets[6], pop.buckets[7], pop.buckets[8]]
  end
  # rubocop:enable Metrics/AbcSize

  def test_should_count_fish
    pop = LanternFishPopulation.new([3, 4, 3, 1, 2])
    assert_equal 5, pop.number_of_fish
    pop.pass_days(18)
    assert_equal 26, pop.number_of_fish
    pop.pass_days(62)
    assert_equal 5_934, pop.number_of_fish
  end

  def test_should_raise_error_for_invalid_input
    error = assert_raises { LanternFishPopulation.new([1, 2, 9]) }
    assert_equal 'IrregularFish', error.message
  end

  def test_should_raise_error_for_empty_input
    error = assert_raises { LanternFishPopulation.new([]) }
    assert_equal 'InvalidPopulation', error.message
  end

  def test_should_raise_error_for_nil_input
    error = assert_raises { LanternFishPopulation.new(nil) }
    assert_equal 'InvalidPopulation', error.message
  end
end
