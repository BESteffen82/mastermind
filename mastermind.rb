# frozen_string_literal: true

require 'pry-byebug'
require './colorize'
require './human'
require './computer'

class Mastermind
  include Colorize
  include Human
  include Computer

  def initialize
    @secret_combo = []
    @turns = 12
    set_secret_combo
  end

  COLORS = %w[RED BLUE GREEN WHITE YELLOW PURPLE].freeze

  def print_rules
    puts "\nWelcome to Mastermind!\n\nChoose to be either code MAKER or code BREAKER.\nCode maker creates a four color secret combination.\nCode breaker tries to guess the secret combination.\n\nThe colors can repeat in the secret combination.\nYou or the computer can make up to 12 guesses.\n\nAfter each guess there will be up to four clues:\nRed peg #{red("\u25C9".encode('utf-8'))}  means a correct color in the correct position.\nWhite peg #{"\u25C9".encode('utf-8')}  means a correct color in the wrong position.\n\nColor choices are: #{red('RED')}, #{blue('BLUE')}, #{green('GREEN')}, WHITE, #{yellow('YELLOW')} and #{purple('PURPLE')}.\n\nGood luck!"
  end

  def role_choice
    puts "\nChoose your role: Press 1 for CODE BREAKER, press 2 for CODE CREATOR"
    @role_choice = gets.chomp.to_i
    case @role_choice
    when 1
      human_play_game
    when 2
      computer_play_game
    else puts 'Invalid response. Respond with 1 or 2'
         role_choice
    end
  end

  def set_secret_combo
    4.times { @secret_combo << COLORS.sample }
  end  

  def check_guess
    @color_pairs = @guess.zip(@secret_combo)
    @color_and_index = @color_pairs.count { |guess_color, secret_color| guess_color == secret_color }
    human, computer = @color_pairs.reject { |guess_color, secret_color| guess_color == secret_color }.transpose
    human.to_a.each do |color|
      comp_color_index = computer.index(color)
      computer.delete_at(comp_color_index) if comp_color_index
    end
    human = [] if human.nil?
    computer = [] if computer.nil?
    @color_only = human.length - computer.length
  end

  def print_clues
    @color_and_index.times { print "#{red("\u25C9".encode('utf-8'))} " }
    @color_only.times { print "#{"\u25C9".encode('utf-8')} " }
  end

  def print_combo
    @combo.each do |color|
      case color
      when 'RED'
        print red(color)
      when 'BLUE'
        print blue(color)
      when 'GREEN'
        print green(color)
      when 'YELLOW'
        print yellow(color)
      when 'PURPLE'
        print purple(color)
      else print color
      end
      print ' '
    end
    puts "\n"
  end

  def play_again
    puts "\n\nPlay again? (Y/N)\n"
    @play_again_answer = gets.downcase.chomp
    case @play_again_answer
    when 'y'
      initialize
      role_choice
    when 'n'
      puts 'Thanks for playing!'
      exit
    else puts 'Invalid answer. Respond with Y or N'
         play_again
    end
  end  
end

new_game = Mastermind.new
new_game.print_rules
new_game.role_choice
new_game.human_play_game
new_game.computer_play_game