# frozen_string_literal: true

require 'pry-byebug'
require 'matrix'
# Board class creates a board object, stores board state, and prints board
class Board
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
  end

  def clear_board
    @board.each do |row|
      row.map! { ' ' }
    end
  end

  def four_in_a_row?
    # check rows
    @board.each do |row|
      row.each_cons(4) do |four|
        return true if four.uniq.length == 1 && four[0] != ' '
      end
    end
    false
  end

  def four_in_a_column?
    # check columns
    @board.transpose.each do |col|
      col.each_cons(4) do |four|
        return true if four.uniq.length == 1 && four[0] != ' '
      end
    end
    false
  end

  def four_in_a_diagonal?
    # check diagonals
    four = (0..3).collect { |i| @board[i][i] }
    return true if four.uniq.length == 1 && four[0] != ' '

    false
  end

  def move(row, col, marker)
    @board[row][col] = marker
  end

  def print_board
    i = 0
    puts '     A   B   C   D   E   F   G'
    puts '   +---+---+---+---+---+---+---+'
    puts " 1 | #{@board[0][0]} |   |   |   |   |   |   |"
    puts '   +---+---+---+---+---+---+---+'

    5.times do
      i += 2
      puts " #{i} |   |   |   |   |   |   |   |"
      puts '   +---+---+---+---+---+---+---+'
    end
  end
end
