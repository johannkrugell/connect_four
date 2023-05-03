# frozen_string_literal: true

require './lib/player'
require './lib/board'

# Game class creates a game object, stores game state, and prints game
class Game
  attr_accessor :board, :player1, :player2, :current_player, :turn

  def initialize
    @board = Board.new
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    @current_player = @player1
    @turn = 0
  end

  def game_over?
    return true if @board.four_in_a_row?
    return true if @board.four_in_a_column?
    return true if @board.four_in_a_diagonal?
    return true if @turn == 42

    false
  end

  def play_game?
    puts 'Would you like to play a game of connect four? (y/n)'
    answer = gets.chomp.downcase
    return true if answer == 'y'
  end

  def play
    loop do
      @board.print_board
      @current_player.enter_coordinates
      @board.move(@current_player.row, @current_player.col, @current_player.marker)
      break if game_over?

      @turn += 1
      switch_players
    end
    @board.print_board
    puts 'Game over!'
  end

  def switch_players
    @current_player = @current_player == @player1 ? @player2 : @player1
    puts "It's your turn, #{@current_player}."
  end
end