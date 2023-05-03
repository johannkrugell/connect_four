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
    puts " 1 | #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} | #{@board[0][3]} | #{@board[0][4]} | #{@board[0][5]} | #{@board[0][6]} |"
    puts '   +---+---+---+---+---+---+---+'

    5.times do
      i += 1
      puts " #{i} | #{@board[i][0]} | #{@board[i][1]} | #{@board[i][2]} | #{@board[i][3]} | #{@board[i][4]} | #{@board[i][5]} | #{@board[i][6]} |"
      puts '   +---+---+---+---+---+---+---+'
    end
  end

  def populated?
    @board.each do |row|
      return false if row.include?(' ')
    end
    true
  end

  def populate_board
    row = 0
    col = 0
    char_array = ('A'..'G').to_a
    6.times do
      7.times do
        move(row, col, char_array.sample)
        col += 1
      end
      col = 0
      row += 1
    end
  end

  def tie?
    if four_in_a_row? == false &&
       four_in_a_column? == false &&
       four_in_a_diagonal? == false &&
       populated? == true
      true
    else
      false
    end
  end

  def valid_move?(row, col)
    # check if move is valid
    return true if row.between?(0, 6) && col.between?(0, 7) && (@board[row][col] == ' ')

    false
  end

  def winner?
    if four_in_a_row? == true ||
       four_in_a_column? == true ||
       four_in_a_diagonal? == true
      true
    else
      false
    end
  end
end
