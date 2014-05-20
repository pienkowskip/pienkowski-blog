class XML::Formatted::Elements::Inline < XML::Formatted::Element
  def validate(validator)
    result = validate_attrs validator
    result &= validate_rule validator, :block_elements do
      @children.all? { |child| !child.is_a?(XML::Formatted::Elements::Block) }
    end
  end
end