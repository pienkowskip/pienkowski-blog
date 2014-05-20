class XML::Formatted::Elements::Paragraph < XML::Formatted::Elements::Block
  ALLOWED_CHILDREN = [
      XML::Formatted::Data,
      XML::Formatted::Entity,
      XML::Formatted::Elements::Inline,
      XML::Formatted::Elements::Division #TODO: Consider disallowing <div> in <p>.
  ]

  def validate(validator)
    result = validate_attrs validator
    result &= validate_rule validator, :invalid_content do
      @children.all? { |child| ALLOWED_CHILDREN.any? { |klass| child.is_a?(klass) } }
    end
  end

end