class Player
  attr_reader :color

  def initialize(color,board)
    @board = board
    @color = color
  end

  def get_move
    raise 'Not implemented'
  end

end