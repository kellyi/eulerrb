require 'memoist'

class Problem20203
  extend Memoist

  PROBLEM_FILE = './lib/eulerrb/advent_2020_3.txt'.freeze
  OPEN_SQUARE = '.'.freeze
  TREE_SQUARE = '#'.freeze
  Slope = OpenStruct
  Coordinates = OpenStruct
  STARTING_COORDINATES = Coordinates.new(x: 0, y: 0).freeze

  def solve
    { part_one: solve_part_one, part_two: solve_part_two }
  end

  private

  def solve_part_one
    traverse_map(slope: Slope.new(x: 3, y: 1))
  end

  def solve_part_two
    [
      Slope.new(x: 1, y: 1),
      Slope.new(x: 3, y: 1),
      Slope.new(x: 5, y: 1),
      Slope.new(x: 7, y: 1),
      Slope.new(x: 1, y: 2)
    ].inject(1) { |acc, next_slope| acc * traverse_map(slope: next_slope) }
  end

  def traverse_map(slope:, coordinates: STARTING_COORDINATES, tree_count: 0)
    next_coordinates = increment_coordinates(coordinates: coordinates, slope: slope)

    case map[coordinates.y][coordinates.x]
    when TREE_SQUARE
      traverse_map(slope: slope, coordinates: next_coordinates, tree_count: tree_count.succ)
    when OPEN_SQUARE
      traverse_map(slope: slope, coordinates: next_coordinates, tree_count: tree_count)
    end
  rescue NoMethodError
    tree_count
  end

  def increment_coordinates(coordinates:, slope:)
    Coordinates.new(x: coordinates.x + slope.x, y: coordinates.y + slope.y)
  end

  def map
    File.read(PROBLEM_FILE).split.collect { |row| row.concat(row * 1000).split('') }
  end

  memoize :map, :traverse_map
  private_constant :PROBLEM_FILE, :OPEN_SQUARE, :TREE_SQUARE, :Slope, :Coordinates, :STARTING_COORDINATES
end
