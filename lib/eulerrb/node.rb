require 'memoist'

class Node
  extend Memoist

  def initialize(matrix:, y:, x:, cache: nil)
    @matrix = matrix
    @y = y
    @x = x
    @cache = cache || {}
  end

  def left
    if x.zero?
      nil
    else
      Node.new(matrix: matrix, y: y, x: x.pred, cache: @cache)
    end
  end

  def right
    if x.succ == matrix.first.length
      nil
    else
      Node.new(matrix: matrix, y: y, x: x.succ, cache: @cache)
    end
  end

  def up
    if y.zero?
      nil
    else
      Node.new(matrix: matrix, y: y.pred, x: x, cache: @cache)
    end
  end

  def down
    if y.succ == matrix.length
      nil
    else
      Node.new(matrix: matrix, y: y.succ, x: x, cache: @cache)
    end
  end

  def weight
    matrix.dig(y, x)
  end

  def cost_distance_81 # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    return cached_cost_distance if cached_cost_distance

    distance = weight + if right.nil? && down.nil?
                          0
                        elsif right.nil?
                          down.cost_distance_81
                        elsif down.nil?
                          right.cost_distance_81
                        else
                          [down.cost_distance_81, right.cost_distance_81].compact.min
                        end

    @cache["#{y}, #{x}"] = distance
    distance
  end

  private

  def cached_cost_distance
    @cache.dig("#{y}, #{x}")
  end

  attr_reader :matrix, :y, :x, :cache

  memoize :left, :right, :up, :down, :weight, :cost_distance_81
end
