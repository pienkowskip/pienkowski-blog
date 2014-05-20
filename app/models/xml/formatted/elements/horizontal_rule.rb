class XML::Formatted::Elements::HorizontalRule < XML::Formatted::Elements::Block
  def validate(validator)
    result = validate_attrs validator
    result &= validate_rule(validator, :not_empty) { empty? }
  end
end