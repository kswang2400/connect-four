  
class Game
  attr_accessor :game_board
  attr_reader :size

  def initialize(player1, player2, size)
    @game_board = Board.new(size)
    @size = size
    @player1 = player1
    @player2 = player2
    @continue = true
    @turn = 0
  end


  def self.setup
    puts "Player 1! What is your name? "
    p1 = gets.chomp

    puts "Player 2! What is your name? "
    p2 = gets.chomp

    puts "What size board would you like? Please enter an integer."
    size = gets.chomp.to_i

    puts "How many in a row do you need to win?"
    win_count = gets.chomp.to_i

    # haven't written validations for names, board size and win count

    player1 = Player.new(p1, " X ", size, win_count)
    player2 = Player.new(p2, " 0 ", size, win_count)

    Game.new(player1, player2, size)
  end


  def end_game(name)
    print_board
    puts "\n\n#{name} wins!\n\n"
    @continue = false
  end

  def game_play
    while @continue
      print_board
      player = switch_turn
      column = get_input(player).to_i
      play_piece(player, column)
      @turn += 1
    end
  end

  def get_input(player)
    p "#{player.name}, it's your turn. Where do you want to play? "
    
    gets.chomp
  end

  def print_board
    @game_board.print_board
  end

  def play_piece(player, column)
    row, column = @game_board.set_piece(player.symbol, column)
    player.remember_piece(row, column)
    end_game(player.name) if player.check_win
  end

  def switch_turn
    (@turn % 2 == 0) ? @player1 : @player2
  end
end