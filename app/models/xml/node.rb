class XML::Node
  attr_reader :parent, :children

  def initialize(parent)
    raise ArgumentError, "invalid class of argument passed to #{self.class.name} constructor" unless parent.nil? or parent.is_a?(XML::Node)

    @parent = parent
    @children = []
    @parent.append(self) unless @parent.nil?
  end

  def append(node)
    raise ArgumentError, "invalid class of argument passed to #{self.class.name}.append method" unless node.is_a?(XML::Node)

    @children.append(node)
  end

  def root
    if @parent.nil?
      self
    else
      @parent.root
    end
  end

  def size
    @children.size
  end

  def empty?
    size < 1
  end

  def traverse_dfs
    _traverse_dfs(0) { |a, b| yield a, b if block_given? }
  end

  def to_s
    "#<#{self.class.name} children: [...](#{@children.size})>"
  end

  protected

  def _traverse_dfs(depth)
    yield self, depth if block_given?
    @children.each do |child|
      child._traverse_dfs(depth+1) { |a, b| yield a, b if block_given? }
    end unless @children.nil?
  end
end