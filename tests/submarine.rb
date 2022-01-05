# frozen_string_literal: true

require_relative '../lib/submarine'
require 'minitest/autorun'

# Test for submarine.
class SubmarineTest < Minitest::Test
  TEST_COURSE = [
    'forward 5',
    'down 5',
    'forward 8',
    'up 3',
    'down 8',
    'forward 2'
  ].freeze

  def test_calculate_final_destination
    sub = Submarine.new
    sub.plot_course(TEST_COURSE)
    assert sub.final_destination == 150
  end

  def test_resets_course
    sub = Submarine.new
    sub.plot_course(TEST_COURSE)
    assert sub.final_destination == 150

    sub.plot_course(['down 2', 'forward 2'])
    assert sub.final_destination == 4
  end

  def test_should_handle_single_comand
    sub = Submarine.new
    sub.plot_course(['forward 1'])
    assert sub.final_destination.zero?
  end

  def test_should_handle_invalid_comand
    sub = Submarine.new
    sub.plot_course(['down 2', 'around 3', 'forward 2'])
    assert sub.final_destination == 4

    sub.plot_course(['down 2', '', 'forward 2'])
    assert sub.final_destination == 4
  end

  def test_should_handle_nil_comand
    sub = Submarine.new
    sub.plot_course(['down 2', nil, 'forward 2'])
    assert sub.final_destination == 4
  end
end
