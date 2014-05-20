class XML::Formatted::Elements::Division < XML::Formatted::Elements::Block
  allowed_attrs :style

  def validate(validator)
    validate_attrs validator
  end

  def render(renderer)
    "<#{@name}#{render_attrs(renderer)}>#{render_content(renderer)}</#{@name}>"
  end
end