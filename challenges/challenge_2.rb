# frozen_string_literal: true

require_relative '../lib/submarine'

if __FILE__ == $PROGRAM_NAME
  puts 'Running challenge 2'

  submarine = Submarine.new
  course = File.readlines('challenges/challenge_2_input')
  submarine.plot_course(course)
  puts submarine.final_destination
end
