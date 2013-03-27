require 'rspec'
require 'board'

describe Board do

  subject { Board.new }

  describe "#initialize" do
    it "sets up a board" do
      subject.get_piece([3,3]).color.should == :white
      subject.get_piece([3,4]).color.should == :black
      subject.get_piece([4,3]).color.should == :black
      subject.get_piece([4,4]).color.should == :white
    end
  end

  describe "#render" do
    it "renders the board" do
      subject.render.should == [
        "        ",
        "        ",
        "        ",
        "   WB   ",
        "   BW   ",
        "        ",
        "        ",
        "        "
      ]
    end
  end

  describe "#winner?" do
    it "detects when no player has won" do
      subject.winner?.should be_false
    end

    it "detects a win when player is killed" do
      subject.set_piece([3,4], Piece.new(:white, [3, 4], subject))
      subject.set_piece([4,3], Piece.new(:white, [4, 3], subject))
      subject.winner?.should == :white
    end

    it "detects a draw" do
      subject.matrix.each do |row|
        0.upto(3) do |num|
          row[num] = Piece.new(:white, [row, num], subject)
          row[num + 4] = Piece.new(:black, [row, num], subject)
        end
      end
      subject.winner?.should == :draw
    end

    it "detects a win when board is full" do
      subject.matrix.each do |row|
        0.upto(4) do |num|
          row[num] = Piece.new(:white, [row, num], subject)
          row[num + 3] = Piece.new(:black, [row, num], subject)
        end
      end
      subject.winner?.should == :white
    end
  end

  describe "#dup" do
    it "copies a board" do
      subject.dup.matrix.flatten.each_with_index do |cell, i|
        unless cell.nil?
          cell.color.should == subject.matrix.flatten[i].color
        else
          subject.matrix.flatten[i].should be_nil
        end
      end
    end
  end
end
