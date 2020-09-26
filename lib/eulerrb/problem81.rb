# typed: true
require_relative './node.rb'

class Problem81
  TEST_FILE = './lib/eulerrb/problem81.txt'.freeze
  PROBLEM_FILE = './lib/eulerrb/p081_matrix.txt'.freeze

  def initialize
    @beginning_node = Node.new(matrix: matrix, y: 0, x: 0)
  end

  def solve
    @beginning_node.cost_distance_81
  end

  private

  attr_reader :beginning_node

  def matrix
    @matrix ||= File
                .read(PROBLEM_FILE)
                .split("\n")
                .collect { |n| n.split(',').collect(&:to_i) }
  end
end
