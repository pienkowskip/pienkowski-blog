class XML::Formatted::Elements::Break < XML::Formatted::Elements::Inline
  def validate(validator)
    result = validate_attrs validator
    result &= validate_rule(validator, :not_empty) { empty? }
  end

  def size
    1
  end
end