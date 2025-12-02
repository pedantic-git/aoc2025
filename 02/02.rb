#!/usr/bin/env ruby

acc1, acc2 = 0, 0

ARGF.read.scan(/(\d+)-(\d+)/) do |l,r|
  (l.to_i).upto(r.to_i) do |n|
    acc1 += n if /\A(.+)\1\Z/ =~ n.to_s
    acc2 += n if /\A(.+)\1+\Z/ =~ n.to_s
  end
end

puts acc1, acc2

