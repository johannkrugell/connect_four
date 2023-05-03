# frozen_string_literal: true

require './lib/player'
require './lib/board'
require './lib/game'

require 'minitest/autorun'

# Tests Player class
class TestPlayer < Minitest::Test
  def setup
    @@player_count = 0
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
  end

  def test_player_marker
    assert_equal "\u2663", @player1.marker
    assert_equal "\u2664", @player2.marker
  end

  def test_player_name
    assert_equal 'Player 1', @player1.name
    assert_equal 'Player 2', @player2.name
  end

  def test_player_select_coordinates
    @player1.stub :enter_coordinates, 'A1' do
      assert_equal [0, 0], @player1.convert_coordinates
    end
  end

  def teardown
    @player1 = nil
    @player2.remove_instance_variable(:@marker)
    @@player_count = 0
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

# Test Game class
class TestGame < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_current_player
    assert 1, @game.current_player
  end

  def test_turn_count
    assert_equal 0, @game.turn
  end

  def test_game_over_turns?
    @game.turn = 42
    assert_equal true, @game.game_over?
  end

  def test_game_over_rows
    @game.board.move(0, 0, 'X')
    @game.board.move(0, 1, 'X')
    @game.board.move(0, 2, 'X')
    @game.board.move(0, 3, 'X')
    assert_equal true, @game.game_over?
  end

  def test_game_over_columns
    @game.board.move(0, 0, 'X')
    @game.board.move(1, 0, 'X')
    @game.board.move(2, 0, 'X')
    @game.board.move(3, 0, 'X')
    assert_equal true, @game.game_over?
  end

  def test_game_over_diagonals
    @game.board.move(0, 0, 'X')
    @game.board.move(1, 1, 'X')
    @game.board.move(2, 2, 'X')
    @game.board.move(3, 3, 'X')
    assert_equal true, @game.game_over?
  end

  def test_switch_players
    @game.switch_players
    assert_equal 'Player 2', @game.current_player.name
  end
end
