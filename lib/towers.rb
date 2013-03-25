class Towers
  attr_accessor :array1, :array2, :array3

  def initialize
    @array1, @array2, @array3 = [3,2,1] ,[],[]
  end

  def move(source, dest)
    tower = [@array1, @array2, @array3]
    dest = tower[dest-1]
    source = tower[source - 1]
    raise "can't place large disk on top of small one" if !dest.empty? && dest.last < source.last
    dest << source.pop
  end

  def win?
    array2 == [3, 2, 1] || array3 == [3, 2, 1]
  end

  def render
    p array1
    p array2
    p array3
  end

  def play
    until win?
      render
      puts "Please choose a peg to move from"
      from = gets.chomp.to_i
      puts "Please choose a peg to move to"
      to = gets.chomp.to_i
      begin
        move(from, to)
      rescue
        puts "Invalid move"
      end
    end
    puts "you win!"
  end
end