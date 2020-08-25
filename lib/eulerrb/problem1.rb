class Problem1
  def initialize
    @numbers = *(1...1000)
  end

  def solve
    @numbers
      .select { |n| multiple_of_three_or_five?(n: n) }
      .inject(:+)
  end

  def multiple_of_three_or_five?(n:)
    multiple_of_three?(n: n) || multiple_of_five?(n: n)
  end

  private

  attr_reader :numbers

  def multiple_of_three?(n:)
    n.modulo(3).zero?
  end

  def multiple_of_five?(n:)
    n.modulo(5).zero?
  end
end
