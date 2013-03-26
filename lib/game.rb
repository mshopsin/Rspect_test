class Game

  attr_accessor :board, :player1, :player2

  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
  end

  def play_loop
    counter = 0
    current_player = player1
    until @board.winner?
      current_player = counter.even? ? player1 : player2
      set(get(current_player), current_player.color)
      counter += 1
    end
    puts "Yay! #{@board.winner?} wins!"
  end

  def get(player)
    player.get_move
  end

  def set(position, color)
    @board.place_piece(position, color).perform_kill
  end

end