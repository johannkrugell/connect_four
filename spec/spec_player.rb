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