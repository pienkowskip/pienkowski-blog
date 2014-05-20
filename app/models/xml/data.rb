class XML::Data < XML::Node
  attr_reader :data
  delegate :empty?, to: :@data
  delegate :size, to: :@data

  def initialize(parent, data)
    super(parent)
    data = data.to_s unless data.is_a?(String)
    @data = data
    @children = nil
  end

  def append(data)
    data = data.to_s unless data.is_a?(String)
    @data << data
  end

  def to_s
    data = @data[0..19]
    data << '...' if data.length < @data.length
    "#<#{self.class.name} data: #{data.inspect}(#{@data.length})>"
  end
end