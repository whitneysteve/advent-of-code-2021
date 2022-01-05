# frozen_string_literal: true

require_relative 'course_command'

# Class to represent submarine.
class Submarine
  def initialize
    @depth = 0
    @horizontal = 0
  end

  # Plot the course for the submarine. Course commands are in the form <direction> <distance>. Each
  # command will move the submarine <distance> units in the specified <direction>. Distances must be
  # positive. Invalid commands and commands that would move the submarine to an invalid location
  # will just be logged and ignored.
  #
  # Valid commands are:
  # - forward
  # - down
  # - up
  #
  # @param [Array<String>] course String array containing the course commands.
  def plot_course(course)
    @depth = 0
    @horizontal = 0

    @final_destination = nil
    @course = course

    course.each { |command_str| process_command(command_str) }
  end

  def final_destination
    @final_destination ||= @depth * @horizontal
  end

  private

  def process_command(command_str)
    command = CourseCommand.parse(command_str)
    if command.nil?
      puts "Invalid command #{command_str}"
      return
    end

    if command.depth?
      update_depth(command)
    elsif command.horizontal?
      update_horizontal(command)
    end
  end

  def update_depth(command)
    new_depth = @depth + command.distance

    if new_depth.negative?
      puts "Command #{command} would move sub to invalid depth: #{new_depth}"
    else
      @depth = new_depth
    end
  end

  def update_horizontal(command)
    if command.distance.negative?
      puts "Command #{command} would move sub backwards"
    else
      @horizontal += command.distance
    end
  end
end
