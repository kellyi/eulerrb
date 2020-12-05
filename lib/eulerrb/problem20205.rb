require 'memoist'

class BoardingPass
  ROW_RANGE = (0..127).freeze
  COLUMN_RANGE = (0..7).freeze
  TAKE_LOWER_HALF_OF_ROW = 'F'.freeze
  TAKE_UPPER_HALF_OF_ROW = 'B'.freeze
  TAKE_LOWER_HALF_OF_COLUMN = 'L'.freeze
  TAKE_UPPER_HALF_OF_COLUMN = 'R'.freeze

  def initialize(instructions:)
    @row_instructions = instructions.take 7
    @column_instructions = instructions.drop 7
  end

  def seat_id
    seat.row * 8 + seat.column
  end

  private

  attr_reader :row_instructions, :column_instructions

  def seat
    OpenStruct.new(row: row&.first, column: column&.first)
  end

  def column
    column_instructions.inject(COLUMN_RANGE) do |accumulator, next_instruction|
      case next_instruction
      when TAKE_LOWER_HALF_OF_COLUMN
        accumulator.take(accumulator.count / 2)
      when TAKE_UPPER_HALF_OF_COLUMN
        accumulator.drop(accumulator.count / 2)
      end
    end
  end

  def row
    row_instructions.inject(ROW_RANGE) do |accumulator, next_instruction|
      case next_instruction
      when TAKE_LOWER_HALF_OF_ROW
        accumulator.take(accumulator.count / 2)
      when TAKE_UPPER_HALF_OF_ROW
        accumulator.drop(accumulator.count / 2)
      end
    end
  end
end

class Problem20205
  extend Memoist

  PROBLEM_FILE = './lib/eulerrb/advent_2020_5.txt'.freeze

  def solve
    { part_one: solve_part_one, part_two: solve_part_two }
  end

  private

  def solve_part_one
    boarding_passes.collect(&:seat_id).max
  end

  def solve_part_two
    seat_ids = boarding_passes.collect(&:seat_id).sort
    ((seat_ids.first..seat_ids.last).to_a - seat_ids).first
  end

  def boarding_passes
    File.read(PROBLEM_FILE).split.collect { |data| BoardingPass.new(instructions: data.split('')) }
  end

  memoize :boarding_passes
end
