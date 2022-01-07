# frozen_string_literal: true

require_relative '../lib/status_report'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 3'

  report_data = File.readlines('challenges/challenge_3_input')
  status_report = StatusReport.new(report_data)
  puts status_report.power_consumption
end
