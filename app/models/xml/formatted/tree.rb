class XML::Formatted::Tree < XML::Tree
  CLASS_MAP = {
      root: 'Root',
      p: 'Paragraph',
      div: 'Division',
      blockquote: 'BlockQuote',
      hr: 'HorizontalRule',
      ul: 'UnorderedList',
      ol: 'OrderedList',
      li: 'ListItem',
      img: 'Image',
      em: 'Emphasis',
      strong: 'Strong',
      code: 'Code',
      u: 'Underline',
      br: 'Break',
      a: 'Anchor',
      del: 'Deleted'
  }
  (1..6).each { |n| CLASS_MAP[:"h#{n}"] = 'Header'}
  CLASS_MAP.each { |name, klass| CLASS_MAP[name] = "XML::Formatted::Elements::#{klass}".constantize }
  private_constant :CLASS_MAP

  attr_reader :errors_pipeline

  def initialize(input)
    @errors_pipeline = []
    super(input)
  end

  def valid?
    @errors_pipeline.empty? && @root.is_a?(XML::Formatted::Element)
  end

  #TODO: Remove 'pretty_print' in production.
  def pretty_print
    return 'INVALID TREE' unless valid?
    output = ''
    @root.traverse_dfs { |node, depth, _| output << "#{'  ' * depth}#{node}\n" }
    output
  end

  protected

  def _raise(exception)
    @errors_pipeline.push exception
  end

  def element_factory(name)
    name = name.downcase if name.is_a?(Symbol)
    klass = CLASS_MAP.fetch(name, XML::Formatted::Elements::Unknown)
    @current = klass.new(@current, name)
  end

  def data_factory(data)
    data.gsub!(/\s+/, ' ')
    data.split(XML::Formatted::Entity::PATTERN).each_with_index do |chunk, index|
      if index.even?
        cdata_factory(chunk)
      else
        entity_factory(chunk)
      end
    end
  end

  private

  def cdata_factory(data)
    return if data.empty?
    if @current.children.last.is_a?(XML::Formatted::Data)
      @current.children.last.append(data)
    else
      XML::Formatted::Data.new(@current, data)
    end
  end

  def entity_factory(value)
    XML::Formatted::Entity.new(@current, value)
  end
end