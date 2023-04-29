# frozen_string_literal: true

require './lib/player'
require './lib/board'

require 'minitest/autorun'

# Tests Player class
class TestPlayer < Minitest::Test
  def setup
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
  end

  def teardown
    @player1.remove_instance_variable(:@marker)
    @player2.remove_instance_variable(:@marker)
    @@player_count = 0
  end

  def test_player_marker
    assert_equal 'Player 1', @player1.name
    assert_equal "\u2663", @player1.marker
    assert_equal "\u2664", @player2.marker
  end
end

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
end
