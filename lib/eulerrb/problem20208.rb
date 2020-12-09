require 'memoist'

class Array
  def contains_duplicates?
    uniq.count != count
  end
end

class Problem20208
  extend Memoist

  PROBLEM_FILE = './lib/eulerrb/advent_2020_8.txt'.freeze
  Instruction = OpenStruct
  Result = OpenStruct
  ACC = 'acc'.freeze
  JMP = 'jmp'.freeze
  NOP = 'nop'.freeze
  TERMINATING = 'terminating'.freeze
  NON_TERMINATING = 'non_terminating'.freeze

  def solve
    { part_one: solve_part_one, part_two: solve_part_two }
  end

  private

  def solve_part_one
    run_program.value
  end

  def solve_part_two # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    instructions.collect.with_index do |ins, index|
      case ins.code
      when ACC
        next
      when JMP
        revised_program = instructions.dup
        revised_program[index] = Instruction.new(code: NOP, value: ins.value)
        run_program(program: revised_program)
      when NOP
        revised_program = instructions.dup
        revised_program[index] = Instruction.new(code: JMP, value: ins.value)
        run_program(program: revised_program)
      end
    end.compact.select { |result| result.type == TERMINATING }.first.value # rubocop:disable Style/MultilineBlockChain
  end

  def run_program(program: instructions) # rubocop:disable Metrics/MethodLength
    accumulator = 0
    executed_instructions = []
    instruction_index = 0

    loop do
      instruction = program[instruction_index]
      executed_instructions << instruction

      raise 'duplicate instruction found' if executed_instructions.contains_duplicates?

      case instruction.code
      when ACC
        accumulator += instruction.value
        instruction_index += 1
      when JMP
        instruction_index += instruction.value
      when NOP
        instruction_index += 1
      end
    end
  rescue RuntimeError
    Result.new(type: NON_TERMINATING, value: accumulator)
  rescue NoMethodError
    Result.new(type: TERMINATING, value: accumulator)
  end

  def instructions
    File.read(PROBLEM_FILE).split("\n").collect.with_index do |line, id|
      code, value = line.split
      Instruction.new(code: code, value: value.to_i, id: id)
    end
  end

  memoize :instructions
end
