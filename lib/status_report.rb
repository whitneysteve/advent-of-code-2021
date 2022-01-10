# frozen_string_literal: true

# Class to represent and compute common data from a status report.
class StatusReport
  # Create a new status report
  #
  # @param [Array<String>] data array of Strings containing the binary values in String format.
  def initialize(data)
    raise 'InvalidStatusReport' if data.to_a.empty?

    @data = data&.compact&.map { |row| pre_process_row(row) }
  end

  # Calculate the power consumption from the status report.
  #
  # @return the integer value representing power consumption.
  def power_consumption
    gamma * epsilon
  end

  # Calculate the life support rating from the status report.
  #
  # @return the integer value representing life support rating.
  def life_support
    oxygen_generator_rating * co2_scrubber_rating
  end

  private

  def gamma
    @gamma ||= gamma_epsilon[:gamma].to_i(2)
  end

  def epsilon
    @epsilon ||= gamma_epsilon[:epsilon].to_i(2)
  end

  def oxygen_generator_rating
    @oxygen_generator_rating ||= filter_by_commonality(@data, least_common_value: false).join.to_i(2)
  end

  def co2_scrubber_rating
    @co2_scrubber_rating ||= filter_by_commonality(@data, least_common_value: true).join.to_i(2)
  end

  def gamma_epsilon
    return @gamma_epsilon unless @gamma_epsilon.nil?

    gamma_str = ''
    epsilon_str = ''

    @data.transpose.each_with_index do |_, i|
      gamma_str += most_common_value(@data, i)
      epsilon_str += least_common_value(@data, i)
    end

    @gamma_epsilon ||= { gamma: gamma_str, epsilon: epsilon_str }
  end

  def most_common_value(arr, idx)
    column = arr.transpose[idx]

    zero_count = column.count do |value|
      value == '0'
    end

    if zero_count > (column.size - zero_count)
      '0'
    else
      '1'
    end
  end

  def least_common_value(arr, idx)
    if most_common_value(arr, idx) == '0'
      '1'
    else
      '0'
    end
  end

  def filter_by_commonality(arr, least_common_value: false)
    remaining = arr
    i = 0

    while remaining.length > 1
      remaining = remaining.filter do |reading|
        reading[i] == (least_common_value ? least_common_value(remaining, i) : most_common_value(remaining, i))
      end
      i += 1
    end

    remaining[0]
  end

  def pre_process_row(row)
    row&.strip&.split('')
  end
end
