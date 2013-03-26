require 'rspec'
require 'board'

describe Piece do

  describe "#places" do
    subject { Board.new }

    it "returns list of possible moves, horizontal and vertical" do
      subject.get_piece([3, 3]).places.should == [[3, 5], [5, 3]]
    end
    context "when setting tile [3,3]" do
      let(:new_piece) { Piece.new(:black, [3,3], subject)}
      before {subject.set_piece([3, 3], new_piece)}
      it "can set a piece" do
        subject.get_piece([3, 3]).color.should == :black
      end

      it "returns list of possible moves including diagonals" do
        subject.get_piece([4, 4]).places.should =~ [[2, 2], [2, 4], [4, 2]]
      end

      it "returns moves over multiple squares" do
        new_piece2 = Piece.new(:black, [4, 2], subject)
        subject.set_piece([4, 2], new_piece2)
        subject.get_piece([4, 4]).places.should =~ [[2, 2], [2, 4], [4, 1]]
      end
    end

  end



end