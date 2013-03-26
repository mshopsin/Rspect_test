class Piece

  attr_accessor :color, :location, :board

  INDICES = [[-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1],  [-1, -1], [0, -1]]
  def initialize(color, location, board)
    @color, @location, @board = color, location, board
  end

  def render
    @color == :white ? "W" : "B"
  end

  def places
    output_moves = []
    lx = location[0]
    ly = location[1]
    INDICES.each do |index|
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

  def killer_moves
    super_kill = []
    lx = location[0]
    ly = location[1]
    INDICES.each do |index|
      lesser_kill = []
      ix = index[0]
      iy = index[1]
      next_pos = [lx + ix, ly + iy]
      #puts "#{index} index"
      if next_is_enemy (next_pos)
          lesser_kill << next_pos.dup
          next_pos = [next_pos[0] + ix, next_pos[1] + iy]
          #puts "#{next_pos} next"
          until !@board.in_bounds?(next_pos)
            if found_my_team(next_pos)
              super_kill.push(*lesser_kill)
              break
            else
              lesser_kill << next_pos.dup
              next_pos = [next_pos[0] + ix, next_pos[1] + iy]
            end
          end
      end
    end

    super_kill
  end

  def perform_kill
    killer_moves.each do |victim|
      victim_piece = @board.get_piece(victim)
      raise "that victim is nil" if victim_piece.nil?
      victim_piece.flip
    end
  end

  def flip
    @color = (@color == :white) ? :black : :white
  end

  def found_my_team(position)
    @board.get_piece(position).color == @color
  end


  def found_self(next_pos)
    @board.get_piece(next_pos).color == @color
  end

  def open_spot(next_pos)
    @board.get_piece(next_pos).nil?
  end

  def next_is_enemy(next_pos)
    @board.get_piece(next_pos)!= nil && @board.get_piece(next_pos).color != @color
  end
end