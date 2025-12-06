#!/usr/bin/env ruby
p ARGF.readlines.map(&:split).transpose.map {|l| l.pop.then {l.map(&:to_i).reduce(it.to_sym)}}.sum
