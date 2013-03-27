require 'rspec'
require 'aiplayer'
require 'board'
require 'player'

describe AIPlayer do
  let( :board ) { Board.new }
  let( :start_moves ) { [[2, 4], [3, 5], [4, 2], [5,3]] }
  subject { AIPlayer.new( :white, board ) }
  it "should make a valid first move" do
    start_moves.should include(subject.get_move)
  end

  it "should make best move" do
    board.place_piece([3, 5], :black)
    subject.get_move.should == [3,6]
  end



end