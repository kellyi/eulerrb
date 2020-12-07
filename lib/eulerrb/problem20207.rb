require 'memoist'

class Problem20207
  extend Memoist

  PROBLEM_FILE = './lib/eulerrb/advent_2020_7_test.txt'.freeze
  SHINY_GOLD = 'shiny gold'.freeze

  def solve
    { part_one: solve_part_one, part_two: :not_yet_implemented }
  end

  private

  def solve_part_one
    rules.keys.collect { |bag| find_shiny_gold_bag(bag: bag) }.flatten.compact.uniq.count
  end

  def find_shiny_gold_bag(bag:, containing_bags: nil)
    return containing_bags if bag == SHINY_GOLD

    rules.fetch(bag)&.collect { |t| find_shiny_gold_bag(bag: t.bag, containing_bags: [containing_bags, bag]) }
  end

  # def solve_part_two
  #   rules.fetch(SHINY_GOLD).collect { |t| count_bags_in_shiny_gold_bag(bag: t) }
  # end

  # def count_bags_in_shiny_gold_bag(bag:, count: 0)
  #   collection = rules.fetch(bag.bag)

  #   if collection.nil?
  #     count
  #   else
  #     count + collection.collect do |t|
  #       count_bags_in_shiny_gold_bag(bag: t, count: bag.number * t.number)
  #     end.inject(:+)
  #   end
  # end

  def rules # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    File.read(PROBLEM_FILE).split("\n").inject({}) do |accumulator, next_rule|
      key, _discard, value = next_rule.partition(' bags contain ')

      adjusted_value = unless value.start_with?('no other ')
                         value.delete_suffix('.').split(', ').collect do |v|
                           tokens = v.split(' ')

                           OpenStruct.new(number: tokens.first.to_i,
                                          bag: tokens.drop(1).take(2).join(' '))
                         end
                       end

      { "#{key}" => adjusted_value }.merge(accumulator)
    end.freeze
  end

  memoize :rules
end
