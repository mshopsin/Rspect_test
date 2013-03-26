require 'rspec'
require 'game'

describe Game do
  context "when running helper functions" do
    let(:player1) { double("Human").stub(:get_move => [2, 4], :color => :white) }
    let(:player2) { double("Computer").stub(:get_move => [4, 5], :color => :black) }
    subject { Game.new(player1, player2) }

    its(:board) { should_not be_nil }

    describe "#get" do
      it "gets move from Human" do
        player1.should_receive(:get_move)
        subject.get(player1)
      end
    end

    describe "#set" do
      it "places a move on the board and performs kills" do
        subject.set([2, 4], :white)
        subject.board.get_piece([3,4]).color.should == :white
        subject.board.get_piece([2,4]).color.should == :white
      end
    end
  end

  context "when testing for a win" do
    let(:player1) { double("Human", :get_move => [4, 5], :color => :white) }
    let(:player2) { double("Computer", :get_move => [1, 1], :color => :black) }
    subject { Game.new(player1, player2) }
    let(:piece1) { Piece.new(:white, [3, 4], subject.board) }
    let(:piece2) { Piece.new(:black, [4, 4], subject.board) }
    let(:piece3) { Piece.new(:white, [4, 2], subject.board) }

    before do
      subject.board.set_piece([3, 4], piece1)
      subject.board.set_piece([4, 4], piece2)
      subject.board.set_piece([4, 2], piece3)
    end

    describe "#play_loop" do
      its "asking a player for a move, placing it, winning" do
        subject.play_loop
        subject.board.get_piece([4, 3]).color.should == :white
        subject.board.get_piece([4, 4]).color.should == :white
        subject.board.get_piece([4, 5]).color.should == :white
      end
    end
  end

end