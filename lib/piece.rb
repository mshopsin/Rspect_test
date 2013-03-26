class Piece

  attr_accessor :color, :location, :board

  def initialize(color, location, board)
    @color, @location, @board = color, location, board
  end

  def render
    @color == :white ? "W" : "B"
  end

  def places
    possible_moves = []
    indices = [[-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1],  [-1, -1], [0, -1]]
    output_moves = []

    lx = location[0]
    ly = location[1]
    indices.each do |index|
      ix = index[0]
      iy = index[1]
      next_pos = [lx + ix, ly + iy]
      #puts "#{index} index"
      if next_is_enemy (next_pos)
          next_pos = [next_pos[0] + ix, next_pos[1] + iy]
          #puts "#{next_pos} next"
          until !@board.in_bounds?(next_pos)
            if open_spot(next_pos)

              output_moves << next_pos
              break
            break if found_self(next_pos)
            else

              next_pos = [next_pos[0] + ix, next_pos[1] + iy]
            end
          end
      end
    end

  output_moves
  end

  def found_self(next_pos)
    @board.get_piece(next_pos).color == @color
  end

  def open_spot(next_pos)
    @board.get_piece(next_pos).nil?
  end

  def next_is_enemy(next_pos)
    puts
    @board.get_piece(next_pos)!= nil && @board.get_piece(next_pos).color != @color
  end
end