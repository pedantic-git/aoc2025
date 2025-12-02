#!/usr/bin/env ruby

def invalid?(n)
  /\A(.+)\1\Z/ =~ n.to_s
end

acc = 0

ARGF.read.scan(/(\d+)-(\d+)/) do |l,r|
  (l.to_i .. r.to_i).each do |n|
    acc += n if invalid?(n)
  end
end

puts acc
