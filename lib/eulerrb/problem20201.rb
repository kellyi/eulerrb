require 'memoist'

class Problem20201
  extend Memoist

  PROBLEM_FILE = './lib/eulerrb/advent_2020_1.txt'.freeze

  def solve
    {
      part_one: solve_for_combination_count(combination_count: 2),
      part_two: solve_for_combination_count(combination_count: 3)
    }
  end

  private

  def solve_for_combination_count(combination_count:)
    numbers
      .combination(combination_count)
      .select { |n| n.inject(:+) == 2020 }
      .flatten
      .inject(:*)
  end

  def numbers
    File.read(PROBLEM_FILE).split.collect(&:to_i)
  end

  memoize :numbers
end
