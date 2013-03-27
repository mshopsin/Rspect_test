require 'rspec'
require 'board'

describe Piece do
  subject(:board) { Board.new }

  describe "#places" do

    it "returns list of possible moves, horizontal and vertical" do
      board.get_piece([3, 3]).places.should == [[3, 5], [5, 3]]
    end

    context "when setting tile [3,3]" do
      let(:new_piece) { Piece.new(:black, [3,3], subject)}
      before {board.set_piece([3, 3], new_piece)}

      it "can set a piece" do
        board.get_piece([3, 3]).color.should == :black
      end

      it "returns list of possible moves including diagonals" do
        board.get_piece([4, 4]).places.should =~ [[2, 2], [2, 4], [4, 2]]
      end

      it "returns moves over multiple squares" do
        new_piece2 = Piece.new(:black, [4, 2], board)
        board.set_piece([4, 2], new_piece2)
        board.get_piece([4, 4]).places.should =~ [[2, 2], [2, 4], [4, 1]]
      end
    end

    describe "#killer_moves" do
      it "outputs a kill list" do
        board.place_piece([2, 4], :white).killer_moves.should == [[3, 4]]
      end

      it "kill list contains multiple enemies" do
        board.place_piece([2, 4], :black)
        board.place_piece([1, 4], :white).killer_moves.should =~ [[3, 4], [2, 4]]
      end
    end

    describe "#perform_kill" do
      it "kills enemy piece" do
        board.place_piece([2, 4], :white).perform_kill
        board.get_piece([3, 4]).color.should == :white
      end

      it "kills multiple enemy pieces" do
        board.place_piece([2, 4], :black)
        board.place_piece([1, 4], :white).perform_kill
        board.get_piece([3, 4]).color.should == :white
        board.get_piece([2, 4]).color.should == :white
      end

    end

  end



end