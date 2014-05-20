class XML::Formatted::Elements::Unknown < XML::Formatted::Element
  def validate(validator)
    validator.add(self, :occurred)
    false
  end

  def render(renderer)
    raise XML::RenderingError, 'do not know how to render unknown element'
  end
end