#!/usr/bin/env ruby

require_relative '../utils/grid.rb'

class Floor < Grid

  def color(v, c)
    case c
    when '#'
      {color: :red, mode: :bright}
    when 'X'
      {color: :green}
    else
      super
    end
  end

end

f = Floor.from_coords(ARGF)
puts f
