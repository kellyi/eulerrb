require 'memoist'

class Problem20206
  extend Memoist

  PROBLEM_FILE = './lib/eulerrb/advent_2020_6.txt'.freeze

  def solve
    { part_one: solve_part_one, part_two: solve_part_two }
  end

  private

  def solve_part_one
    questionnaires.collect { |q| q.join.split('').uniq.count }.inject(:+)
  end

  def solve_part_two
    questionnaires.collect do |q|
      q.collect { |s| Set.new(s.chars) }.inject { |acc, next_value| acc & next_value }.count
    end.inject(:+)
  end

  def questionnaires
    File.read(PROBLEM_FILE).split("\n\n").collect { |q| q.split("\n") }
  end

  memoize :questionnaires
end
