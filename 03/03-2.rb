#!/usr/bin/env ruby

# Find the largest digit in bank ensuring there are rem chars remaining
# then return whatever is left in bank after the digit
def find_next(rem, bank)
  max = bank[0..-1-rem].max
  new_bank = bank[bank.index(max)+1..-1]
  [max, new_bank]
end

def joltage(bank)
  found = []
  new_bank = bank
  11.downto(0) { max, new_bank = find_next(it, new_bank); found << max }
  found.join.to_i
end

puts ARGF.inject(0) {|acc,s| acc + joltage(s.chomp.chars)}