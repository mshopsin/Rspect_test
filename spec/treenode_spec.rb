require 'rspec'
require 'treenode'

describe Treenode do

  describe "#initialize" do
    it "sets the children up correctly" do
      t = Treenode.new(1)
      t.left.should == nil
      t.right.should == nil
      t.value == 1
    end
  end

  describe "#set_left" do
    it "should insert left child into tree" do
      t = Treenode.new(9)
      l1 = Treenode.new(8)
      l2 = Treenode.new(7)
      t.set_left(l1)
      l1.set_left(l2)
      l1.left.should == l2
    end
  end

  describe "#dfs" do
    it "should search the child nodes dfs" do
      t = Treenode.new(0)
      l1 = Treenode.new(1)
      r1 = Treenode.new(3)
      t.left = l1
      t.right = r1
      l2 = Treenode.new(2)
      r2 = Treenode.new(4)
      l1.left = l2
      l1.right = r2
      l1.should_receive(:dfs).ordered.and_call_original
      l2.should_receive(:dfs).ordered.and_call_original
      r1.should_receive(:dfs).ordered.and_call_original
      t.dfs(4)
    end
  end

  describe "#bfs" do
    it "should search the child nodes bfs" do
      t = Treenode.new(0)
      l1 = Treenode.new(1)
      r1 = Treenode.new(3)
      t.left = l1
      t.right = r1
      l2 = Treenode.new(2)
      r2 = Treenode.new(4)
      l1.left = l2
      l1.right = r2
      l1.should_receive(:value).ordered.and_call_original
      r1.should_receive(:value).ordered.and_call_original
      l2.should_receive(:value).ordered.and_call_original
      t.bfs(4)
    end
  end
end















