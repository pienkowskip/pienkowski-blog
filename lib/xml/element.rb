class XML::Element < XML::Node
  attr_reader :name, :attrs

  def initialize(parent, name)
    raise ArgumentError, "invalid class of argument passed to #{self.class.name} constructor (expected Symbol)" unless name.is_a?(Symbol)
    super(parent)
    @name = name
    @attrs = {}
  end

  def initialize_copy(other)
    super
    @attrs = @attrs.clone
  end

  def set_attr(name, value)
    raise ArgumentError, "invalid class of argument passed to #{self.class.name}.set_attr method (expected Symbol)" unless name.is_a?(Symbol)
    value = value.to_s unless value.is_a?(String)
    @attrs[name] = value
  end

  def to_s
    attrs = [:name, :attrs].map { |name| "#{name}: #{send(name).inspect}" }
    attrs.push("children: [...](#{@children.size})")
    "#<#{self.class.name} " + attrs.join(', ') + ">"
  end
end