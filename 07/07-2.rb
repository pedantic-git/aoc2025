#!/usr/bin/env ruby

require_relative '../utils/grid'

class Tachyon < Grid

  attr_accessor :row, :splits, :universes

  def initialize(*)
    super
    @row = 1
    @splits = 0
    @universes = [self]
  end

  def process!
    until row == height
      process_row!
    end
  end

  def process_row!
    us = universes.dup
    puts "Row #{row}: currently #{us.length} universes!"
    0.upto(width-1) do |x|
      us.each do |u|
        if %w[S |].include? u[row-1, x]
          if u[row,x] == '^'
            u2 = u.dup
            u[row,x-1] = '|'
            u2[row,x+1] = '|'
            universes << u2
          else
            u[row, x] = '|'
          end
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
puts t.universes.length
