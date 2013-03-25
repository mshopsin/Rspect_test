class Treenode

  attr_accessor :left, :right, :value

  def initialize(value)
    @left = nil
    @right = nil
    @value = value
  end

  def dfs(value)
    if @value == value
       return self
    end
       vl = nil
       vr = nil
       vl = @left.dfs(value) if @left
       vr = @right.dfs(value) if @right
    if vl
      return vl
    else
      return vr
    end
  end

  def bfs(value)
    queue = []
    queue << self
    until queue.empty?
      node = queue.shift
      return node if node.value == value
      queue << node.left if node.left
      queue << node.right if node.right
    end

    nil
  end

end
