class XML::Formatted::Elements::Header < XML::Formatted::Elements::Block
  def validate(validator)
    result = validate_attrs validator
    result &= validate_rule validator, :invalid_content do
      @children.all? do |child|
        ([XML::Formatted::Data, XML::Formatted::Entity, XML::Formatted::Elements::Inline].any? { |k| child.is_a? k }) &&
            ([XML::Formatted::Elements::Image, XML::Formatted::Elements::Anchor].all? { |k| !child.is_a?(k) })
      end
    end
  end

  def size
    2
  end
end