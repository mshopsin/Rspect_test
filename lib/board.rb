require 'piece.rb'

class Board

  attr_accessor :matrix, :counter

  def initialize
    @matrix = Array.new(8) { [nil] * 8 }

    set_piece([3,3], Piece.new(:white,[3,3],self))
    set_piece([3,4], Piece.new(:black,[3,4],self))
    set_piece([4,3], Piece.new(:black,[4,3],self))
    set_piece([4,4], Piece.new(:white,[4,4],self))
    @counter = Hash.new(0)
    count
  end

  def render
    @matrix.map do |row|
      row.map do |cell|
        if cell.nil?
          " "
        else
          cell.render
        end
      end.join
    end
  end

  def get_piece(position)
    x = position[0]
    y = position[1]
    @matrix[x][y]
  end

  def set_piece(position, piece)
    x = position[0]
    y = position[1]
    @matrix[x][y] = piece
  end

  def place_piece(position, color)
    new_piece = Piece.new(color, position, self)
    set_piece(position, new_piece)
    new_piece
  end

  def winner?  #returns the sym of the winner or draw if game is over, false if game is still in play
    count
    if @counter[nil] == 0
      if @counter[:white] == @counter[:black]
        return :draw
      end
      return @counter[:white] > @counter[:black] ? :white : :black
    end
    if @counter[:white] == 0
      :black
    elsif @counter[:black] == 0
      :white
    else
      false
    end
  end

  def in_bounds?(position)
    x = position[0]
    y = position[1]
    x >= 0 && x <= 7 && y >= 0 && y <= 7
  end

  def count
    @counter = Hash.new(0)
    @matrix.each do |row|
      row.each do |piece|
        unless piece.nil?
          @counter[piece.color] +=1
        else
          @counter[piece] += 1
        end
      end
    end
  end

  def dup
    new_board = Board.new
    @matrix.each_with_index do |row, index|
      output_row = []
      row.each do |cell|
        if cell.nil?
          output_row << cell
        else
          output_row << cell.dup(new_board)
        end
      end
      new_board.matrix[index] = output_row
    end

    new_board
  end
end

b = Board.new
p b.render