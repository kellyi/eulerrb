# typed: true
require 'forwardable'
require 'singleton'

class Cache
  include Singleton
  extend Forwardable

  def_delegators :@cache, :count

  def initialize
    @cache = {}
  end

  def get(key:)
    cache.dig(key)
  end

  def set(key:, value:)
    cache[key] = value
  end

  def reset
    @cache = {}
  end

  private

  attr_reader :cache
end
