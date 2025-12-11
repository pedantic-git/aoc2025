#!/usr/bin/env ruby

class Line

  attr_accessor :ans, :buttons, :state

  def initialize(str)
    /\[([.#]+)\] (.*) \{.*\}/.match str
    @ans = $1.chars.map {it == '#'}
    @buttons = $2.split(' ').map {it.scan(/\d+/).map(&:to_i)}
    reset!
  end

  def reset!
    @state = Array.new(ans.length, false)
  end

  def push_button!(button)
    button.each {state[it] = !state[it]}
  end

  # Given n, test every n combinations of buttons to see if it can create ans
  def test(n)
    buttons.repeated_combination(n) do |bs|
      reset!
      bs.each {push_button! it}
      return true if state == ans
    end
    return false
  end

  # Find the smallest value of n for which test(n) is true
  def value
    (1..).find {test it}
  end

end

lines = ARGF.map {Line.new it}
p lines.sum {it.value}
