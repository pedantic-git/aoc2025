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
  end

  def add_range!(s)
    r = s.split('-').then {_1.to_i .. _2.to_i}
    @ranges << r
  end

  def fresh?(n)
    ranges.any? {it.include? n.to_i}
  end

  def n_fresh
    io.count {fresh? it}
  end

end

i = Ims.new(ARGF)
p i.n_fresh
