#!/usr/bin/env ruby

acc1, acc2 = 0, 0

ARGF.read.scan(/(\d+)-(\d+)/) do |l,r|
  (l.to_i).upto(r.to_i) do
    acc1 += it if /\A(.+)\1\Z/ =~ it.to_s
    acc2 += it if /\A(.+)\1+\Z/ =~ it.to_s
  end
end

puts acc1, acc2