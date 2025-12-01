#!/usr/bin/env ruby

class Dial
  attr_reader :acc, :pass, :pass_click

  def initialize
    @acc = 50
    @pass = 0
    @pass_click = 0
  end

  def turn!(n)
    @pass_click += clicks(acc,n)
    @acc = (acc + n) % 100
    @pass += 1 if acc.zero?
  end

  # How many times do we pass 0 if we apply n to acc?
  def clicks(acc,n)
    res = acc + n
    rotations = (res.abs / 100)
    if (acc.zero? && res < 0) || (res > 0)
      rotations
    else
      # If we didn't start at zero and we end up negative, we passed zero
      # during the first rotation, so add 1
      rotations + 1
    end
  end

  # Returns the numeric value of the given instruction
  def inst_n(inst)
    /([LR])(\d+)/.match(inst).captures.then {|d,n| n.to_i * (d=='L'?-1:1)}
  end

  def load!(f)
    f.each {turn! inst_n(_1)}
  end
end

d = Dial.new
d.load!(ARGF)
puts d.pass
puts d.pass_click
