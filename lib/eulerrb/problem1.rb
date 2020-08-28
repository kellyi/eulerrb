class Problem1
  def initialize
    @numbers = *(1...1000)
  end

  def solve
    @numbers
      .select { |n| multiple_of_three_or_five?(number: n) }
      .inject(:+)
  end

  def multiple_of_three_or_five?(number:)
    multiple_of_three?(number: number) || multiple_of_five?(number: number)
  end

  private

  attr_reader :numbers

  def multiple_of_three?(number:)
    number.modulo(3).zero?
  end

  def multiple_of_five?(number:)
    number.modulo(5).zero?
  end
end
