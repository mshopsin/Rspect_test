require 'player.rb'
require 'debugger'

class AIPlayer < Player

  def get_move

    best_placement = nil
    best_kills = 0

    0.upto(7) do |row|
      0.upto(7) do |col|
        #debugger
        unless @board.get_piece([row,col])
          test_board = @board.dup
          current_kills = test_board
                          .place_piece([row,col], @color)
                          .killer_moves
                          .count
          best_placement, best_kills = [row, col], current_kills if current_kills > best_kills
        end
      end
    end

    best_placement
  end

end
