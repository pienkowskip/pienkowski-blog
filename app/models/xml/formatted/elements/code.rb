class XML::Formatted::Elements::Code < XML::Formatted::Elements::Inline
  def validate(validator)
    result = validate_attrs validator
    result &= validate_rule validator, :invalid_content do
      @children.all? { |child| child.is_a?(XML::Formatted::Data) || child.is_a?(XML::Formatted::Entity) }
    end
  end
end