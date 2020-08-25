require "eulerrb/version"

module Eulerrb
  class Error < StandardError; end

  def self.solve(problem:)
    require "eulerrb/problem#{problem}"
    Object.const_get("Problem#{problem}").new.solve
  rescue LoadError
    raise StandardError.new 'not yet implemented'
  end
end
