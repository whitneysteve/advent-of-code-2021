# frozen_string_literal: true

require_relative '../lib/grid'
require_relative '../lib/point'

# Simulation to model the flashing of octopodes.
class FlashingOctopus
  attr_reader :flash_count, :synchronised_flashes

  def initialize(grid)
    @grid = Grid.new(grid)
    @flash_count = 0
    @cycle_count = 0
    @synchronised_flashes = []

    @points = []
    @grid.height.times.each do |y|
      @grid.width.times.each do |x|
        @points << Point.new(x, y)
      end
    end
  end

  def progress(num_cycles)
    num_cycles.times.each do |_|
      progress_internal
      @cycle_count += 1
    end
  end

  private

  def progress_internal
    to_flash = increment_energy
    flashed = flash(to_flash)
    @synchronised_flashes << (@cycle_count + 1) if flashed.size == @grid.size
    reset_flashed(flashed)
  end

  def reset_flashed(flashed)
    flashed.each do |point|
      @grid.update_value(point, 0)
    end
  end

  def flash(flashes)
    flashed = []
    until flashes.empty?
      next_flash = flashes.pop
      next if flashed.include?(next_flash)

      new_flashes = increment_energy_array(@grid.get_all_neighbours(next_flash))
      flashes.concat(new_flashes.reject { |p| flashed.include?(p) })

      @flash_count += 1
      flashed << next_flash
    end
    flashed
  end

  def increment_energy
    increment_energy_array(@points)
  end

  def increment_energy_array(arr)
    flashes = []
    arr.each do |point|
      new_value = @grid.get_value(point) + 1
      @grid.update_value(point, new_value)
      flashes << point if new_value > 9
    end
    flashes
  end
end
