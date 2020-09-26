# typed: true

require 'sorbet-runtime'

module Utils
  extend T::Sig

  sig { params(multiplicand: Numeric, multiplier: Numeric).returns(Numeric) }
  def self.multiply(multiplicand:, multiplier:)
    multiplicand * multiplier
  end
end
