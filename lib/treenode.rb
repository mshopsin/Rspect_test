class Treenode

  attr_accessor :left, :right, :parent, :value

  def initialize(value)
    @left = nil
    @right = nil
    @parent = nil
    @value = value
  end

  def set_left(node)
    @left.parent = nil if @left
    @left = node
    node.parent = self
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
