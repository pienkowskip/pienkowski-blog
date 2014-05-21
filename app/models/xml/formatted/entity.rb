class XML::Formatted::Entity < XML::Node
  PATTERN = /(\&\w+\;)/

  attr_reader :value

  def initialize(parent, value)
    super(parent)
    value = value.to_s unless value.is_a?(String)
    match = value.match PATTERN
    if match && match.captures.size == 1 && match.captures.first == value
      @value = value
      @children = nil
    else
      raise ArgumentError, "invalid format of argument passed to #{self.class.name} constructor"
    end
  end

  def initialize_copy(other)
    super
    @children = nil
    @data = @value.clone
  end

  def size
    1
  end

  def empty?
    false
  end

  def render(renderer)
    @value
  end

  def to_s
    "#<#{self.class.name} value: #{value.inspect}>"
  end
end