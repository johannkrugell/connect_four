# frozen_string_literal: true

require './lib/player'
require './lib/board'

require 'pry-byebug'

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

  def self.exit_game?
    exit
  end

  def game_over?
    if @board.four_in_a_row? || @board.four_in_a_column? || @board.four_in_a_diagonal?
      @board.print_board
      puts "#{@current_player.name} wins! Game over!"
      return true
    elsif @turn == 42 || @board.tie?
      @board.print_board
      puts 'Game over! Tie game!'
      return true
    end
    false
  end

  def game_tied?
    return true if @board.tie?
  end

  def self.play_game?
    puts 'Would you like to play a game of connect four? (y/n)'
    answer = gets.chomp.downcase
    return true if answer == 'y'
  end

  def play
    player1.assign_name
    player2.assign_name
    loop do
      @board.print_board
      player_coordinates = valid_move?
      @board.move(player_coordinates[1], player_coordinates[0], @current_player.marker)
      break if game_over?

      @turn += 1
      switch_players
    end
  end

  def valid_move?
    loop do
      player_coordinates = @current_player.convert_coordinates
      return player_coordinates if @board.valid_move?(player_coordinates[1], player_coordinates[0]) == true

      puts 'Invalid move, try again.'
      sleep(2)
      Display.clear_display
      @board.print_board
    end
  end

  def switch_players
    @current_player = @current_player == @player1 ? @player2 : @player1
    puts "It's your turn, #{@current_player}."
  end
end
