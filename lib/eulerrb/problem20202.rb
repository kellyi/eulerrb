require 'memoist'

class Problem20202
  extend Memoist

  PROBLEM_FILE = './lib/eulerrb/advent_2020_2.txt'.freeze

  def solve
    {
      part_one: solve_part_one,
      part_two: solve_part_two
    }
  end

  private

  def solve_part_one
    passwords.select do |password|
      (password.lower..password.higher) === password.str.count(password.char)
    end.count
  end

  def solve_part_two
    passwords.select do |password|
      (password.str[password.lower.pred] == password.char) ^ (password.str[password.higher.pred] == password.char)
    end.count
  end

  def passwords
    File.read(PROBLEM_FILE).split.each_slice(3).collect do |password|
      OpenStruct.new(
        lower: password[0].split('-').first.to_i,
        higher: password[0].split('-').last.to_i,
        char: password[1][0],
        str: password[2]
      )
    end
  end

  memoize :passwords
end
