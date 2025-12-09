#!/usr/bin/env ruby
require 'matrix'

# Find the size of a rectangle between vectors c1 and c2
def rect(c1,c2)
  x = [c1[0], c2[0]].sort.reverse.reduce(:-) + 1
  y = [c1[1], c2[1]].sort.reverse.reduce(:-) + 1
  x * y
end

coords = ARGF.readlines.map {it.split(',').map(&:to_i).then {Vector[*it]}}
p coords.combination(2).map { rect _1, _2 }.max