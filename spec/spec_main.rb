# frozen_string_literal: true

require './lib/player'

require 'minitest/autorun'

class TestPlayer < Minitest::Test
  def setup
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
  end

  def test_player_name
    assert_equal 'Player 1', @player1.name
  end

  def test_player_marker
    assert_equal "\u2663", @player1.marker
    assert_equal "\u2664", @player2.marker
  end
end
