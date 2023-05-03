# frozen_string_literal: true

require './lib/player'
require './lib/board'
require './lib/game'

require 'minitest/autorun'

# Tests Board class
class TestBoard < Minitest::Test
  def setup
    @board = Board.new
  end

  def test_board_move
    @board.move(0, 0, "\u2663")
    assert_equal "\u2663", @board.board[0][0]
  end

  def test_four_in_a_row
    @board.move(0, 0, 'X')
    @board.move(0, 1, 'X')
    @board.move(0, 2, 'X')
    @board.move(0, 3, 'X')
    assert_equal true, @board.four_in_a_row?
  end

  def test_four_in_a_column
    @board.move(0, 0, 'X')
    @board.move(1, 0, 'X')
    @board.move(2, 0, 'X')
    @board.move(3, 0, 'X')
    assert_equal true, @board.four_in_a_column?
  end

  def test_four_in_a_diagonal
    @board.move(0, 0, 'X')
    @board.move(1, 1, 'X')
    @board.move(2, 2, 'X')
    @board.move(3, 3, 'X')
    assert_equal true, @board.four_in_a_diagonal?
  end

  def test_clear_board
    @board.move(0, 0, 'X')
    @board.clear_board
    assert_equal ' ', @board.board[0][0]
  end

  def test_tie
    row = 0
    col = 0
    char_array = (1..42).to_a
    6.times do
      7.times do
        marker = char_array.sample
        @board.board.include?(marker) ? char_array.delete(marker) : marker
        @board.move(row, col, marker)
        col += 1
      end
      col = 0
      row += 1
    end
    assert_equal true, @board.tie?
  end

  def test_valid_move?
    assert_equal true, @board.valid_move?(0, 0)
  end

  def test_invalid_move_coordinates_used
    @board.move(0, 0, 'X')
    assert_equal false, @board.valid_move?(0, 0)
  end

  def test_invalid_move_coordinates_out_of_bounds
    assert_equal false, @board.valid_move?(0, 8)
  end

  def test_winner?
    @board.move(0, 0, 'X')
    @board.move(0, 1, 'X')
    @board.move(0, 2, 'X')
    @board.move(0, 3, 'X')
    assert_equal true, @board.winner?
  end
end
