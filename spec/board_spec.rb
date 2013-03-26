require 'rspec'
require 'board'

describe Board do

  describe "#initialize" do
    it "sets up a board" do
      board = Board.new
      board.get_piece([3,3]).color.should == :white
      board.get_piece([3,4]).color.should == :black
      board.get_piece([4,3]).color.should == :black
      board.get_piece([4,4]).color.should == :white
    end
  end

  describe "#render" do
    it "renders the board" do
      Board.new.render.should ==[["        "],
                                 ["        "],
                                 ["        "],
                                 ["   WB   "],
                                 ["   BW   "],
                                 ["        "],
                                 ["        "],
                                 ["        "]]
    end
  end

  describe "#winner?" do
    it "detects when no player has won" do
      board = Board.new
      board.winner?.should be_false
    end

    it "detects a win when player is killed" do
      board = Board.new
      board.set_piece([3,4], Piece.new(:white, [3, 4], board))#.should == :white
      board.set_piece([4,3], Piece.new(:white, [4, 3], board))#.should == :white
      board.winner?.should == :white
    end

    it "detects a draw" do
      board = Board.new
      board.matrix.each do |row|
        0.upto(3) do |num|
          row[num] = Piece.new(:white, [row, num], board)
          row[num + 4] = Piece.new(:black, [row, num], board)
        end
      end
      board.winner?.should == :draw
    end

    it "detects a win when board is full" do
      board = Board.new
      board.matrix.each do |row|
        0.upto(4) do |num|
          row[num] = Piece.new(:white, [row, num], board)
          row[num + 3] = Piece.new(:black, [row, num], board)
        end
      end
      board.winner?.should == :white
    end

  end
end
