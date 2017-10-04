class Board
  attr_accessor :board #read_write access for the rest of the class

  #a new instance variable of board variable is created
  #when a new instance of class Board is created
  def initialize
    @board = ["1","2","3","4","5","6","7","8","9"]
  end

  #displays board in it's current state
  def display_board
    puts  " #{@board[0]} " + "|" + " #{@board[1]} " + "|" + " #{@board[2]}  "
    puts  "-----------"
    puts  " #{@board[3]} " + "|" + " #{@board[4]} " + "|" + " #{@board[5]}  "
    puts  "-----------"
    puts  " #{@board[6]} " + "|" + " #{@board[7]} " + "|" + " #{@board[8]}  "
  end

  #will make a move based on the position and the character selected
  def move(position, character)
    @board[position.to_i - 1] = character
  end

  #verify that the position spot is empty && the number given is between 1 and 9.
  def valid_move?(position)
    position.to_i.between?(1, 9) && !(@board[position.to_i - 1].downcase == "x") && !(@board[position.to_i - 1].downcase == "o")
  end

  #counting the number of turns that have taken place on the current satate of the board
  def turn_count
    counter = 0
    @board.each{|element| counter += 1 if element.downcase == "x" || element.downcase == "o"}
    return counter
  end

  #check and see if any winning combinations are filled with all x's or o's and returns the index combination
  #will return the array combo if true, else return false.
  def won?
    winning_combinations = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
      ]
    winning_combinations.any? do |combo|
      return combo if ((@board[combo[0]] + @board[combo[1]] + @board[combo[2]]).downcase == "xxx" || (@board[combo[0]] + @board[combo[1]] + @board[combo[2]]).downcase == "ooo")
    end
  end

  #checks to see if all elements on the board are filled out and nobody won.
  def draw?
    @board.all?{|element| element.downcase == "x" || element.downcase == "o"} &&  (won? == false)
  end

  #is it a draw_game, or did some one win? Then Game is over
  def game_over?
    draw? || won?
  end

  #if somebody won then we want to declare them as the winner
  def winner
    "#{@board[won?[0]]}"
  end

  def reset_board
    @board = ["1","2","3","4","5","6","7","8","9"]
  end

  #represents a turn for the board, checks for a valid move and moves it if it is valid.
  def turn(position, character)
    if valid_move?(position)
        move(position, character)
    else
      puts "Stop being silly and try again!"
    end
  end
end
