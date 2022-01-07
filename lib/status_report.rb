# frozen_string_literal: true

# Class to represent and compute common data from a status report.
class StatusReport
  # Create a new status report
  #
  # @param [Array<String>] data array of Strings containing the binary values in String format.
  def initialize(data)
    arr_data = data&.map { |row| pre_process_row(row) }
    @rotated_data = arr_data&.compact&.transpose || []
  end

  # Calculate the power consumption from the status report.
  #
  # @return the integer value representing power consumption.
  def power_consumption
    gamma * epsilon
  end

  private

  def gamma
    gamma_epsilon[:gamma]
  end

  def epsilon
    gamma_epsilon[:epsilon]
  end

  def gamma_epsilon
    return @gamma_epsilon unless @gamma_epsilon.nil?

    gamma_str = ''
    epsilon_str = ''

    @rotated_data.each do |column|
      count1 = column.count { |value| value == '1' }
      count0 = column.length - count1

      gamma_str += count0 > count1 ? '0' : '1'
      epsilon_str += count0 > count1 ? '1' : '0'
    end

    @gamma_epsilon ||= { gamma: gamma_str.to_i(2), epsilon: epsilon_str.to_i(2) }
  end

  def pre_process_row(row)
    row&.strip&.split('')
  end
end
