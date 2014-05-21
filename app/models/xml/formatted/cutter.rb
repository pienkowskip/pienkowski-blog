class XML::Formatted::Cutter
  def cut(root, size)
    raise ArgumentError, "invalid class of argument passed to #{self.class.name}.cut method" unless root.is_a?(XML::Formatted::Element)

    new_root = nil
    root.traverse_dfs(nil) do |node, _, parent|
      if size <= 0
        size = nil
        break
      end
      if size < node.size
        if node.is_a?(XML::Formatted::Data) && size > 0
          node.clone(parent).instance_eval do
            @data = @data.slice(0, size)
            @data.rstrip!
          end
        end
        size = nil
        break
      else
        cloned = node.clone(parent)
        size -= cloned.size
        new_root = cloned if parent.nil?
        cloned
      end
    end

    return false unless size.nil?

    dfs(new_root)
    new_root
  end

  private

  def dfs(elm)
    return false unless elm.is_a? XML::Formatted::Element
    elm.children.reverse_each { |child| return true if dfs(child) }
    if elm.children.any? { |child| child.is_a?(XML::Formatted::Data) || child.is_a?(XML::Formatted::Entity) }
      XML::Formatted::Entity.new(elm, '&hellip;')
      return true
    end
    false
  end
end