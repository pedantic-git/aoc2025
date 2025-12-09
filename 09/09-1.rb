#!/usr/bin/env ruby

coords = ARGF.readlines.map {it.split(',').map(&:to_i)}

# Find the extremes
nw = coords.min_by { [_1, _2] }
ne = coords.min_by { [-_1, _2] }
sw = coords.min_by { [_1, -_2] }
se = coords.min_by { [-_1, -_2] }

# There are more than 2 possible rectangles if the points are weirdly distributed
# but they still involve extremes, right?

p [nw,ne,sw,se].combination(2).map { (it[1][0]-it[0][0]+1) * (it[1][1]-it[1][0]+1) }.max
