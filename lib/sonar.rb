# frozen_string_literal: true

# Class to represent submarine Sonar.
class Sonar
  # Count the number of increases in depth from an array of sonar readings.
  #
  # @param [Array< Number>] readings The array of readings.
  #
  # @return [Number] The number of increases in the readings.
  def self.count_increases(readings)
    arr = readings&.compact
    return 0 if arr.to_a.empty?

    previous = arr[0]
    increases = 0

    arr[1..].compact.each do |reading|
      increases += 1 if reading > previous
      previous = reading
    end

    increases
  end

  # Count the number of increases in depth from an array of sonar readings with a sliding window size.
  #
  # @param [Array<Number>] readings The array of readings.
  # @param [Number] the size of the window used to aggregate readings for comparison.
  #
  # @return [Number] The number of increases in the readings.
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def self.count_increases_with_window(readings, window_size)
    arr = readings&.compact
    return 0 if (window_size || 0) < 1
    return 0 if arr.to_a.length <= window_size

    increases = 0
    first_window_end_pos = window_size

    prev_sum = arr[0..window_size].sum

    while first_window_end_pos < arr.length
      next_reading = arr[first_window_end_pos]
      new_sum = prev_sum + next_reading - arr[first_window_end_pos - window_size]

      increases += 1 if new_sum > prev_sum

      prev_sum = new_sum

      first_window_end_pos += 1
    end

    increases
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
