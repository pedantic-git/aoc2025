#!/usr/bin/env ruby

require_relative '../utils/grid'

class PrintDept < Grid

  def n_accessible
    count {|v,_| accessible? v}
  end

  def accessible?(v=cursor)
    return unless self[v] == '@'
    neighbours_with_char('@', v, diagonal: true).length < 4
  end
end

pd = PrintDept.new(ARGF)
puts pd.n_accessible
