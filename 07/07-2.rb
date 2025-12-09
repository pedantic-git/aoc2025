#!/usr/bin/env ruby

require_relative '../utils/grid'

class Tachyon < Grid

  attr_accessor :row, :splits

  def initialize(*)
    super
    @row = 1
  end

  def process!
    until row == height
      process_row!
    end
  end

  def process_row!
    0.upto(width-1) do |x|
      self[row-1, x] = 1 if self[row-1, x] == 'S' # start is actually 1
      if self[row-1, x].kind_of?(Integer)
        if self[row,x] == '^'
          self[row, x-1] = self[row-1, x] + self[row, x-1].to_i
          self[row, x+1] = self[row-1, x] + self[row, x+1].to_i
        else
          self[row, x] = self[row-1, x] + self[row, x].to_i
        end
      end
    end
    self.row += 1
  end

  def color(v,c)
    case c
    when /\d/, 'E'
      {color: :red, mode: :bright}
    when '^'
      {color: :green, mode: :bright}
    else
      super
    end
  end

  def n_universes
    finish = height-1
    0.upto(width-1).map {self[finish,it]}.select {it.kind_of? Integer}.sum
  end
end

t = Tachyon.new(ARGF)
t.process!
#puts t
puts t.n_universes