# frozen_string_literal: true

module Human
  def human_guess_prompt
    puts "\nTurns left: #{@turns}\nType your 4 color combination (separate colors with a space):"
    @human_guess = gets.chomp.upcase.split
  end

  def human_guess
    human_guess_prompt
    @human_guess.each do |color|
      unless Mastermind::COLORS.include?(color) && @human_guess.length == 4
        puts "\nInvalid answer. Try again!\n\n"
        human_guess_prompt
      end
    end
    @turns -= 1
    @combo = @human_guess
    @guess = @human_guess
  end

  def print_human_game_round
    print "\nYour guess: "
    print_combo
    print 'Clues: '
    print_clues
    puts "\n"
    if @color_and_index == 4
      print yellow("\nThe code is broken! YOU win!!")
      play_again
    end
    if @turns.zero?
      print red("\nYou failed to break the code. YOU lose!")
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
end
