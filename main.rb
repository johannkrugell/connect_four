# frozen_string_literal: true

require './lib/board'
require './lib/display'  
require './lib/game'
require './lib/player'

Display.clear_display
Display.title
Display.instructions

Game.play_game? ? @game = Game.new : Game.exit_game?

@game.play



