#!/usr/bin/env ruby

require_relative '../utils/grid'

class Tachyon < Grid

  attr_accessor :row, :splits

  def initialize(*)
    super
    @row = 1
    @splits = 0
  end

  def process!
    until row == height
      process_row!
    end
  end

  def process_row!
    0.upto(width-1) do |x|
      if %w[S |].include? self[row-1, x]
        if self[row,x] == '^'
          self[row,x-1] = '|'
          self[row,x+1] = '|'
          self.splits += 1
        else
          self[row, x] = '|'
        end
      end
    end
    self.row += 1
  end

  def color(v,c)
    case c
    when '|', 'S'
      {color: :red, mode: :bright}
    when '^'
      {color: :green, mode: :bright}
    else
      super
    end
  end
end

t = Tachyon.new(ARGF)
t.process!
puts t
puts t.splits
