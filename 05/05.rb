#!/usr/bin/env ruby

require 'set'

class Ims
  attr_reader :ranges, :io

  def initialize(io)
    @io = io
    @ranges = Set.new
    until /^$/ =~ (l=io.readline)
      add_range! l
    end
    consolidate!
  end

  def add_range!(s)
    r = s.split('-').then {_1.to_i .. _2.to_i}
    ranges << r
  end

  # Consolidate any ranges that overlap... could be more elegant I reckon
  def consolidate!
    ranges.dup.each do |r|
      if overs = ranges.find_all {(it != r) && it.overlap?(r)}
        to_delete = overs << r
        to_delete.each {ranges.delete it}
        ranges << (to_delete.map(&:min).min .. to_delete.map(&:max).max)
      end
    end
  end

  def fresh?(n)
    ranges.any? {it.include? n.to_i}
  end

  def n_fresh
    io.count {fresh? it}
  end

  def n_possible
    ranges.sum(&:count)
  end

end

i = Ims.new(ARGF)
p i.n_fresh
p i.n_possible
