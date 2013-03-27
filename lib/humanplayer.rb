require './player.rb'

class HumanPlayer < Player

  def get_move
    puts "Make your move: X Y"
    result = gets.chomp
    result.split(" ")
  end

end