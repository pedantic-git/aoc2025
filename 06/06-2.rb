#!/usr/bin/env ruby

problems = ARGF.readlines.map {it.chomp.chars}.transpose.chunk {!it.all? {it==" "} || :_separator}.map(&:last)
solns = problems.map do |arr|
  op = arr[0].pop.to_sym
  arr.map {it.join.to_i}.reduce(op)
end
p solns.sum
