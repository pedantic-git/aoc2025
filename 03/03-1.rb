#!/usr/bin/env ruby

REGEXPS = 99.downto(11).to_h { [it.to_s.chars.then {Regexp.new("#{_1}.*#{_2}")}, it]}

def joltage(bank)
  REGEXPS.find {|r,_| r.match?(bank)}.last
end

puts ARGF.inject(0) {|acc,bank| acc + joltage(bank)}