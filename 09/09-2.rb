#!/usr/bin/env ruby

require 'colorize'
require 'pry'
require 'set'

class Floor

  attr_reader :red, :width, :height

  def initialize(io)
    @red = Set.new io.readlines.map {it.split(',').map(&:to_i)}
    @width = red.max_by {it[0]}[0]
    @height = red.max_by {it[1]}[1]
  end

  # Returns true if v is red or green
  # (technically this doesn't fill in rectangles, but we don't need this for
  # the calculation)
  def red_or_green?(v)
    return true if red.include?(v)
    # It's green if there's a red to the west and east...
    return true if (0..v[0]-1).any? {red.include? [it, v[1]]} && (v[0]+1..width).any? {red.include? [it, v[1]]}
    # ...or a red to the north and south
    return true if (0..v[1]-1).any? { red.include? [v[0], it]} && (v[1]+1..height).any? { red.include? [v[0], it]}
    return false
  end

  # Draw the current grid (only for debugging smaller examples!)
  def to_s
    (0..height).map do |y|
      (0..width).map do |x|
        if red.include? [x,y]
          '#'.colorize(:red)
        elsif red_or_green? [x,y]
          'X'.colorize(:green)
        else
          '.'.colorize(:gray)
        end
      end.join
    end.join("\n")
  end

  def valid_rectangles
    red.to_a.combination(2).select {|c1,c2| valid_rectangle?(c1,c2) }
  end

  # Is the rectangle with corners at c1 and c2 valid?
  # A rectangle is valid if at least one horizontal side and at least one
  # vertical side is _all_ red or green
  def valid_rectangle?(c1,c2)
    left, right = [c1[0],c2[0]].sort
    top, bottom = [c1[1],c2[1]].sort
    top_all_green = (left..right).all? {red_or_green?([it,c1[1]])}
    bottom_all_green = (left..right).all? {red_or_green?([it,c2[1]])}
    left_all_green = (top..bottom).all? {red_or_green?([c1[0],it])}
    right_all_green = (top..bottom).all? {red_or_green?([c2[0],it])}
    #binding.pry if c1 == [7,1] && c2 == [11,7]
    (top_all_green || bottom_all_green) && (left_all_green || right_all_green)
  end

  # Find the size of a rectangle between vectors c1 and c2
  def rect(c1,c2)
    x = (c1[0]-c2[0]).abs + 1
    y = (c1[1]-c2[1]).abs + 1
    x * y
  end

end

f = Floor.new(ARGF)
puts f
p f.valid_rectangles.to_h {[it, f.rect(*it)]}

# require 'pry'
# binding.pry

