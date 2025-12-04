#!/usr/bin/env ruby

require_relative '../utils/grid'

class PrintDept < Grid

  # Is v an accessible roll?
  def accessible?(v=cursor)
    return unless self[v] == '@'
    neighbours_with_char('@', v, diagonal: true).length < 4
  end

  # How many rolls are accessible?
  def n_accessible
    count {|v,_| accessible? v}
  end

  # Remove all the accessible paper and return how many were removed
  def remove_accessible!
    select {|v,_| accessible? v }.tap { _1.each {|v,_| self[v] = 'x'}}.length
  end

  # Keep removing until we can't remove any more
  def n_accessible_remove!
    n = 0
    until (removed = remove_accessible!) == 0
      n += removed
    end
    n
  end
end

pd = PrintDept.new(ARGF)

# Part 1
puts pd.n_accessible

# Part 2
puts pd.n_accessible_remove!
