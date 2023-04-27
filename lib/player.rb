# frozen_string_literal: true

require 'pry-byebug'

# Player class create player objects, stores player name and marker
class Player
  attr_accessor :name, :marker

  @@player_count = 0

  def initialize(name, marker)
    @name = name
    @marker = marker
    @@player_count += 1
    assign_marker
  end

  def self.player_count
    @@player_count
  end

  def assign_marker
    markers = ["\u2663", "\u2664"]
    index = @@player_count - 1
    @marker = markers[index]
  end
end
