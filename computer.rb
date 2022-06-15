module Computer
	def computer_guess_prompt
    puts "\nCreate a 4 color secret combination (separate colors with a space):"
    @human_secret_combo = gets.chomp.upcase.split
    @combo = @human_secret_combo
    @secret_combo = @human_secret_combo
    print "\nYour secret combination: "
    print_combo
  end

	def computer_guess
    @computer_guess = []
    4.times { @computer_guess << Mastermind::COLORS.sample }
    @turns -= 1        
    if @turns < 11 
      computer_logic
      #@turns -= 1
    end                
    @guess = @computer_guess
    @combo = @computer_guess
  end
	
	def print_computer_game_round
    print "\nTurns left: #{@turns}"
    print "\nComputer guess: "
    print_combo    
    print 'Clues: '
    print_clues
    puts "\n"
    if @color_and_index == 4
      print red("\nThe computer broke the code! YOU lose!")
      play_again
    end
    if @turns.zero?
      print yellow("\nThe computer failed to break your code. YOU win!!")
      play_again
    end     
  end

  def computer_logic    
    @color_pairs.each_with_index do |(guess_color, secret_color), index|      
      if guess_color == secret_color        
        @computer_guess[index] = secret_color
      elsif guess_color != secret_color
        @computer_guess[index] = Mastermind::COLORS.sample
      end
    end    
  end

	def computer_play_game
    computer_guess_prompt    
    loop do      
      computer_guess            
      check_guess
      print_computer_game_round                 
      sleep(1)                 
    end
  end
end