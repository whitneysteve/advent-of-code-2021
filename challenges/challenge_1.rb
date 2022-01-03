# frozen_string_literal: true

# Class to represent submarine Sonar.
class Sonar
  # Count the number of increases in depth from an array of sonar readings.
  #
  # @param [Array< Number>] readings The array of readings.
  #
  # @return [Number] The number of increases in the readings.
  def self.count_increases(readings)
    return 0 if readings.to_a.empty?

    previous = readings[0]
    increases = 0

    readings[1..].compact.each do |reading|
      increases += 1 if reading > previous
      previous = reading
    end

    increases
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 1'

  readings = File.readlines('challenges/input').map(&:to_i)
  puts Sonar.count_increases(readings)
end
