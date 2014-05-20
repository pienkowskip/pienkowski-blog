class XML::Tree < ::Ox::Sax
  attr_reader :root

  def initialize(input)
    super()
    io = StringIO.new(input)
    @current = nil
    @root = nil
    Ox.sax_parse(self, io)
    _raise XML::ParsingError.new('Not terminated: tree not terminated') if @root.nil? || !@current.nil?
  end

  # SAX parsing methods:

  def start_element(name)
    element_factory(name)
  end

  def end_element(name)
    _raise XML::ParsingError.new('Out of order: element placed above top level element') if @current.nil?
    _raise XML::ParsingError.new("Start End Mismatch: element '#{name}' close does not match '#{@current.name}' open") if @current.name != name
    if @current.parent.nil?
      _raise XML::ParsingError.new('Out of Order: multiple top level elements') unless @root.nil?
      @root = @current
    end
    @current = @current.parent unless @current.nil?
  end

  def attr(name, value)
    if @current.nil?
      _raise XML::ParsingError.new('Out of order: attributes for no element')
    else
      @current.set_attr(name, value)
    end
  end

  def text(value)
    if @current.nil?
      _raise XML::ParsingError.new('Out of order: content for no element')
    else
      data_factory(value)
    end
  end

  def error(message, line, column)
    _raise XML::ParsingError.new(message, line, column)
  end

  protected

  def element_factory(name)
    @current = XML::Element.new(@current, name)
  end

  def data_factory(data)
    if @current.children.last.is_a?(XML::Data)
      @current.children.last.append(data)
    else
      XML::Data.new(@current, data)
    end
  end

  def _raise(exception)
    raise exception
  end
end