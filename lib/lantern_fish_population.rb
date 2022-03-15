# frozen_string_literal: true

# A way to represent the population of lanter fish.
class LanternFishPopulation
  attr_reader :buckets

  def initialize(initial_population)
    raise 'InvalidPopulation' if initial_population.nil? || initial_population.empty?
    raise 'IrregularFish' if initial_population.any? { |days| days.negative? || days > 8 }

    initialise_buckets(initial_population)
  end

  def pass_days(num_days)
    (0..num_days - 1).each do |_|
      number_in_new_gen = @buckets[0]
      (1..8).each { |days_until_next_fish| @buckets[days_until_next_fish - 1] = @buckets[days_until_next_fish] }
      @buckets[8] = number_in_new_gen
      @buckets[6] += number_in_new_gen
    end
  end

  def number_of_fish
    @buckets.values.sum
  end

  private

  def initialise_buckets(initial_population)
    @buckets = {}
    (0..8).each { |days_until_next_fish| @buckets[days_until_next_fish] = 0 }
    initial_population.each do |days_until_next_fish|
      @buckets[days_until_next_fish] += 1
    end
  end
end
