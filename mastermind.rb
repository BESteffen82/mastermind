require 'pry-byebug'
require './colorize'

class Mastermind
	include Colorize

	def initialize
		@secret_combo = secret_combo
		@all_combos = all_combos
	end

	COLORS = %w[RED BLUE GREEN WHITE YELLOW PURPLE]

	def print_rules
		puts "\nWelcome to Mastermind!\n\nChoose to be either code MAKER or code BREAKER.\nCode maker creates a four color secret combination.\nCode breaker tries to guess the secret combination.\n\nThe colors can repeat in the secret combination.\nYou or the computer can make up to 12 guesses.\n\nAfter each guess there will be up to four clues:\nRed peg #{red("\u25C9".encode('utf-8'))}  means a correct color in the correct position.\nWhite peg #{"\u25C9".encode('utf-8')}  means a correct color in the wrong position.\n\nColor choices are: #{red('RED')}, #{blue('BLUE')}, #{green('GREEN')}, WHITE, #{yellow('YELLOW')} and #{purple('PURPLE')}.\n\nGood luck!\n\n"		
	end

	def role_choice
		puts "Choose your role: Press 1 for CODE BREAKER, press 2 for CODE CREATOR"
	end
	
	def play_game
		print_rules
	end
	
	
end

new_game = Mastermind.new
new_game.play_game


