class XML::Formatted::Elements::List < XML::Formatted::Elements::Block
  def validate(validator)
    result = validate_attrs validator
    result &= validate_rule validator, :invalid_content do
      @children.all? { |child| child.is_a? XML::Formatted::Elements::ListItem }
    end
  end
end