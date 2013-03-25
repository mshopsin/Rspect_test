require 'rspec'
require 'towers'

describe Towers do


  describe "#initialize" do
    it "sets the first array to 3, 2, 1, the second and third to empty" do
      Towers.new.array1.should == [3, 2, 1]
      Towers.new.array2.should be_empty
      Towers.new.array3.should be_empty
    end
  end

  describe "#move" do
   subject(:game) { Towers.new }
    it "should move disks between pegs" do
      game.move(1, 2)
      game.array1.should == [3, 2]
      game.array2.should == [1]
      game.array3.should be_empty
    end

    it "should not place a large disk on top of a smaller one" do
      expect do
        game.move(1,2)
        game.move(1,2)
      end.to raise_error("can't place large disk on top of small one")
    end
  end

  describe "#win?" do
   subject(:game) { Towers.new }
    it "should be able to win" do
      game.array1 = []
      game.array2 = []
      game.array3 = [3,2,1]
      game.win?.should be_true
      game.array1 = []
      game.array3 = []
      game.array2 = [3,2,1]
      game.win?.should be_true
    end
  end

end