# frozen_string_literal: true

require 'pry-byebug'
require './colorize'

class Mastermind
  include Colorize

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

  def human_guess_prompt
    puts "\nTurns left: #{@turns}\nType your 4 color combination (separate colors with a space):"
    @human_guess = gets.chomp.upcase.split
  end

  def computer_guess_prompt
    puts "\nCreate a 4 color secret combination (separate colors with a space):"
    @human_secret_combo = gets.chomp.upcase.split
    @combo = @human_secret_combo
    @secret_combo = @human_secret_combo
    print "\nYour secret combination: "
    print_combo
  end

  def computer_guess
    @turns -= 1
    @computer_guess = []
    4.times { @computer_guess << COLORS.sample }
    @guess = @computer_guess
    @combo = @computer_guess
  end

  def human_guess
    human_guess_prompt
    @human_guess.each do |color|
      unless COLORS.include?(color) && @human_guess.length == 4
        puts "\nInvalid answer. Try again!\n\n"
        human_guess_prompt
      end
    end
    @turns -= 1
    @combo = @human_guess
    @guess = @human_guess
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

  def print_human_game_round
    print "\nYour guess: "
    print_combo
    print 'Clues: '
    print_clues
    puts "\n"
    if @color_and_index == 4
      print red("\nThe code is broken! YOU win!!")
      play_again
    end
    if @turns.zero?
      print red("\nYou failed to break the code. YOU lose!")
      play_again
    end
  end

  def print_computer_game_round
    print "\nTurns left: #{@turns}"
    print "\nComputer guess: "    
    print_combo
    p @guess
    print 'Clues: '
    print_clues
    puts "\n"
    if @color_and_index == 4
      print red("\nThe computer broke your code! YOU lose!")
      play_again
    end
    if @turns.zero?
      print red("\nThe computer failed to break your code. You win!!")
      play_again
    end
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

  def human_play_game
    loop do
      human_guess
      check_guess
      print_human_game_round
    end
  end

  def computer_play_game
    computer_guess_prompt
    loop do
      computer_guess
      check_guess
      print_computer_game_round
      sleep(2)
    end
  end
end

new_game = Mastermind.new
new_game.print_rules
new_game.role_choice
