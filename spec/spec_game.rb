# frozen_string_literal: true

require './lib/player'
require './lib/board'
require './lib/game'

require 'minitest/autorun'

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
