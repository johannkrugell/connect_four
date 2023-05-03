# frozen_string_literal: true

require 'pry-byebug'

# Player class create player objects, stores player name and marker
class Player
  attr_accessor :name, :marker

  @@player_count = 0

  def initialize(name, marker)
    @name = name
    @marker = marker
    assign_marker
    @@player_count += 1
  end

  def self.player_count
    @@player_count
  end

  def assign_marker
    markers = ["\u2663", "\u2664"]
    index = @@player_count
    @marker = markers[index]
  end

  def assign_name
    puts "Enter player #{@@player_count}'s name: "
    @name = gets.chomp
  end

  def convert_coordinates
    coordinates = enter_coordinates
    coordinates = coordinates.split('')
    coordinates[0] = coordinates[0].ord - 65
    coordinates[1] = coordinates[1].to_i - 1
    coordinates
  end

  def enter_coordinates
    puts "#{@name} enter the column and row for your move (A1): "
    gets.chomp
  end

  def print_player_details
    puts "#{@name} your marker is #{@marker}"
  end
end
