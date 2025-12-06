#!/usr/bin/env ruby

def solve(col)
  op = col.pop.to_sym
  ml = col.map(&:length).max
  p col.map {|c| Array.new(ml, "0").then {it[-c.length..-1] = c.chars;it}}.transpose

  col.map(&:to_i).reduce(op)
end

p ARGF.readlines.map(&:split).transpose.map {solve it}.sum
