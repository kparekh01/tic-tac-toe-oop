class TicTacToe
  load 'player.rb'
  load 'board.rb'

  #initialize a new board when a new instance of TicTacToe is created
  def initialize
    @new_board = Board.new
  end

  #get the name and set the position of the player and computer
  def set_name_and_position
    puts "Welcome to Tic-Tac-Toe. Please enter your name:"
    name = gets.chomp
    puts "Please choose which player you want to be(1('X') or 2('O'))"
    position = gets.chomp.to_i
    if position == 1
      @player1 = Player.new(name, "x")
      @computer = Player.new("Tron", "o")
    else
      @computer = Player.new("Tron", "x")
      @player1 = Player.new(name, "o")
    end
    puts "#{@player1.name} is #{@player1.character} and Tron is #{@computer.character}"
  end

  #represents one turn for a player or computer(random picks)
  def make_move(player)
    #available options for the computer to pick from
    available_moves = @new_board.board.join.scan(/\d/)
    if player.name == "Tron"
      puts "Tron is making a move.........."
      sleep(1)
      @new_board.turn(available_moves.sample.to_i, player.character)
      @new_board.display_board
    else
      puts "#{player.name}'s turn. Please choose a number on the grid to place an '#{player.character}'."
      position = gets.chomp
      character = player.character
      @new_board.turn(position, character)
      @new_board.display_board
    end
  end

  #represents the flow of the game for the computer and the player
  def play_game
    @new_board.display_board
    set_name_and_position
    #course of game flow until it's over.  2 scenarios for the computer's character
    while (@new_board.game_over? == false)
      if @computer.character.downcase == 'x'
        if @new_board.turn_count % 2 == 0
          make_move(@computer)
  		  else
  			  make_move(@player1)
  		  end
      else
        if @new_board.turn_count % 2 == 0
          make_move(@player1)
  		  else
  			  make_move(@computer)
  		  end
      end
    end

    #when game is over check for the following below
    if @new_board.game_over? && @new_board.won?
      winner = (@computer.character ==  @new_board.winner) ? @computer : @player1
      puts "#{winner.name} has won this battle!"
    elsif @new_board.game_over? && @new_board.draw?
      puts "Gentlemen, nobody wins on this fine day!"
    else
      puts "If you're seeing this message, something went Horibbbbly Wrooong!"
    end

    #reset board and play again option!
    puts "Press Y to play again, or any other key to quit."
    answer = gets.chomp.downcase
    if answer == "y"
      puts "Let a new game begin!..."
      @new_board.reset_board
      sleep(1)
      play_game()
    else
      abort ("Thanks for Playing! Bye Bye!")
    end
	end
end
