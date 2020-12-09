require 'memoist'

class Problem20209
  extend Memoist

  PROBLEM_FILE = './lib/eulerrb/advent_2020_9.txt'.freeze
  OFFSET = 25

  def solve
    { part_one: solve_part_one, part_two: solve_part_two }
  end

  private

  def solve_part_two
    (2...data.count).each do |window_size|
      data.each_cons(window_size) do |window|
        return window.min + window.max if window.inject(:+) == invalid_number
      end
    end
  end

  def invalid_number
    (OFFSET...data.count).each do |index|
      return data[index] unless valid?(index: index)
    end
  end

  alias solve_part_one invalid_number

  def valid?(index:)
    ((index - OFFSET)...index).each do |left_index|
      (left_index.succ...index).each do |right_index|
        return true if data[left_index] + data[right_index] == data[index]
      end
    end

    false
  end

  def data
    File.read(PROBLEM_FILE).split("\n").collect(&:to_i).freeze
  end

  memoize :data, :invalid_number
end
