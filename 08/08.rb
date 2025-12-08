#!/usr/bin/env ruby

require 'pp'
require 'set'
require 'matrix'

class Circuit
  attr_reader :junctions

  def initialize(v)
    @junctions = Set.new([v])
  end

  def join!(c)
    @junctions = junctions + c.junctions
  end

  def length
    junctions.length
  end

  def inspect
    "#<Circuit #{object_id}>"
  end

end

class Decoration

  attr_reader :circuits

  def initialize(io)
    @junctions = io.map {it.split(',').map(&:to_i).then { Vector[*it] }}
    reset!
  end

  def reset!
    @circuits = @junctions.to_h {[it, Circuit.new(it)]}
  end

  def ordered_pairs
     circuits.keys.combination(2).sort_by {(_1-_2).magnitude}
  end

  # Assign the first n combinations to circuits
  def assign!(n=1000)
    ordered_pairs.first(n).each do |j1,j2|
      join_circuits! j1,j2
    end
  end

  # Keep going until there's only one circuit - return the pair that caused it
  # to close
  def close_up!
    op = ordered_pairs
    pair = nil
    until circuits.values.first.length == circuits.length
      pair = op.pop
      join_circuits! *pair
    end
    pair
  end

  # Join the two circuits that contain j1 and j2
  def join_circuits!(j1,j2)
    p "Joining #{j1.to_a.join(',')} + #{j2.to_a.join(',')}"
    circuits[j1].join!(circuits[j2])
    circuits[j2].junctions.each {circuits[it] = circuits[j1]}
  end

  def ordered_circuits
    Set.new(circuits.values).sort_by(&:length)
  end

  def score
    ordered_circuits.last(3).map(&:length).reduce(:*)
  end
end

# Part 1
d = Decoration.new(ARGF)
# d.assign! 1000
# p d.score

# Part 2
d.reset!
pair = d.close_up!
p pair
p pair[0][0] * pair[1][0]

