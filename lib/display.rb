# frozen_string_literal: true

class Display
  def initialize
    @display = Display.new
  end

  def clear_display
    puts "\e[H\e[2J"
  end

  def instructions
    puts 'Welcome to Connect Four!'
    puts 'The goal of the game is to connect four of your markers in a row.'
    puts 'You can connect four in a row horizontally, vertically, or diagonally.'
    puts 'To place a marker, enter the column letter (A-G) and row number (1-6) where you want to place your marker.'
    puts 'Good luck!'
  end

  def title
    puts "\e[31m"
    puts "   ______                            __       ______                 __"
    puts "  / ____/___  ____  ____  ___  _____/ /_    / ____/___  __  _______/ /"
    puts " / /   / __ \/ __ \/ __ \/ _ \/ ___/ __/   / /_  / __ \/ / / / ___/ /"
    puts "/ /___/ /_/ / / / / / / /  __/ /__/ /_    / __/ / /_/ / /_/ / /  /_/"
    puts "\____/\____/_/ /_/_/ /_/\___/\___/\__/   /_/    \____/\___/_/   (_) "  
    puts " "
    puts "\e[0m"
  end
end