#!/usr/bin/env ruby

coords = ARGF.readlines.map {it.split(',').map(&:to_i)}

# Find the extremes
nw = coords.min_by { [_1, _2] }
ne = coords.min_by { [-_1, _2] }
sw = coords.min_by { [_1, -_2] }
se = coords.min_by { [-_1, -_2] }

p [nw,ne,sw,se]

# There are only two possible rectangles - se-nw or sw-ne
senw = (se[0]-nw[0]+1) * (se[1]-nw[1]+1)
swne = (sw[0]-ne[0]+1) * (sw[1]-ne[1]+1)

p [senw, swne]
