# frozen_string_literal: true

# Representation of a map charting vents below the ocean surface,
class VentMap
  def initialize(vent_lines, include_diagonal: true)
    @max_x = 0
    @max_y = 0

    @lines = include_diagonal ? vent_lines : vent_lines.filter(&:horizontal_or_vertical?)
    determine_bounds(@lines)

    @map = Array.new(@max_y + 1)
    @map.each_with_index { |_, idx| @map[idx] = Array.new(@max_x + 1, 0) }

    @lines.each { |line| draw_line(line) }
  end

  def count_dangerous_points(threshold)
    count = 0
    @map.each do |line|
      count += line.count { |point| point >= threshold }
    end
    count
  end

  def to_s
    s = ''
    @map.each do |line|
      line&.each do |point|
        s += point.zero? ? '.' : point.to_s
      end
      s += "\n"
    end
    s
  end

  private

  def determine_bounds(lines)
    lines.each do |line|
      max_x = [line.start.x, line.finish.x].max
      max_y = [line.start.y, line.finish.y].max

      @max_x = max_x if max_x > @max_x

      @max_y = max_y if max_y > @max_y
    end
  end

  def draw_line(line)
    if line.horizontal_or_vertical?
      draw_horizontal_vertical_line(line)
    else
      draw_diagonal_line(line)
    end
  end

  def draw_horizontal_vertical_line(line)
    points, axis = compute_pointers_and_axis(line)

    pointer = points.min
    finish = points.max

    while pointer < finish + 1
      increment_point(pointer, axis) if line.horizontal?
      increment_point(axis, pointer) if line.vertical?
      pointer += 1
    end
  end

  def compute_pointers_and_axis(line)
    if line.horizontal?
      [[line.start.x, line.finish.x], line.start.y]
    else
      [[line.start.y, line.finish.y], line.start.x]
    end
  end

  def draw_diagonal_line(line)
    start, finish = compute_diagonal_start_finish(line)

    x = start.x
    y = start.y
    right = finish.x > start.x

    while ((right && x <= finish.x) || (!right && x >= finish.x)) && y <= finish.y
      increment_point(x, y)
      x += right ? 1 : -1
      y += 1
    end
  end

  def compute_diagonal_start_finish(line)
    if line.start.y > line.finish.y
      [line.finish, line.start]
    else
      [line.start, line.finish]
    end
  end

  # rubocop:disable Naming/MethodParameterName
  def increment_point(x, y)
    # Never forget, inversion: [y][x]
    @map[y][x] += 1
  end
  # rubocop:enable Naming/MethodParameterName
end
