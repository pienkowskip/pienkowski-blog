class XML::Formatted::Elements::Image < XML::Formatted::Elements::Inline
  allowed_attrs :src, :title, :alt
  def validate(validator)
    result = validate_attrs validator
    result &= validate_rule(validator, :not_empty) { empty? }
  end
end