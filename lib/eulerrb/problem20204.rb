require 'memoist'

class Passport
  def initialize(byr:, iyr:, eyr:, hgt:, hcl:, ecl:, pid:, cid:)
    @byr = byr
    @iyr = iyr
    @eyr = eyr
    @hgt = hgt
    @hcl = hcl
    @ecl = ecl
    @pid = pid
    @cid = cid
  end

  attr_reader :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid

  def required_fields_present?
    [byr, iyr, eyr, hgt, hcl, ecl, pid].compact.count == 7
  end

  def valid?
    valid_byr? && valid_iyr? && valid_eyr? && valid_hgt? && valid_hcl? && valid_ecl? && valid_pid?
  end

  def self.create_passport(data:)
    Passport.new(
      byr: Passport.find_field(field: 'byr', data: data),
      iyr: Passport.find_field(field: 'iyr', data: data),
      eyr: Passport.find_field(field: 'eyr', data: data),
      hgt: Passport.find_field(field: 'hgt', data: data),
      hcl: Passport.find_field(field: 'hcl', data: data),
      ecl: Passport.find_field(field: 'ecl', data: data),
      pid: Passport.find_field(field: 'pid', data: data),
      cid: Passport.find_field(field: 'cid', data: data)
    )
  end

  def self.find_field(field:, data:)
    data.find { |attribute| attribute.start_with?(field) }&.split(':')&.last
  end

  private

  def valid_byr?
    (1920..2002).cover? byr.to_i
  end

  def valid_iyr?
    (2010..2020).cover? iyr.to_i
  end

  def valid_eyr?
    (2020..2030).cover? eyr.to_i
  end

  def valid_hgt?
    return (150..193).cover?(hgt.to_i) if hgt.end_with?('cm')
    return (59..76).cover?(hgt.to_i) if hgt.end_with?('in')

    false
  end

  def valid_hcl?
    hcl =~ /^#\h{6}$/
  end

  def valid_ecl?
    %w[amb blu brn gry grn hzl oth].include?(ecl)
  end

  def valid_pid?
    pid =~ /^\d{9}$/
  end
end

class Problem20204
  extend Memoist

  PROBLEM_FILE = './lib/eulerrb/advent_2020_4.txt'.freeze

  def solve
    { part_one: solve_part_one, part_two: solve_part_two }
  end

  private

  def solve_part_one
    passports.count(&:required_fields_present?)
  end

  def solve_part_two
    passports.select(&:required_fields_present?).count(&:valid?)
  end

  def passports
    File
      .read(PROBLEM_FILE)
      .split("\n\n")
      .collect { |data| data.gsub("\n", ' ').split }
      .collect { |data| Passport.create_passport(data: data) }
  end

  memoize :passports
end
