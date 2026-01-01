#!/usr/bin/env ruby

require 'rgl/adjacency'
require 'rgl/dot'
require 'rgl/traversal'
require 'pry'

class Cables < RGL::DirectedAdjacencyGraph

  attr_reader :dg

  def initialize(io)
    super()
    io.each do |l|
      l.chomp.split(/:? /).then {|inp,*out| out.each {add_edge(inp,it)}}
    end
  end

end

c = Cables.new(ARGF)
binding.pry c