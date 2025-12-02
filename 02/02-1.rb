#!/usr/bin/env ruby

def invalid?(n)
  s = n.to_s
  half = s.length/2
  return if half*2 != s.length
  s[0,half] == s[half,half] 
end

acc = 0

ARGF.read.scan(/(\d+)-(\d+)/) do |l,r|
  (l.to_i .. r.to_i).each do |n|
    acc += n if invalid?(n)
  end
end

puts acc
