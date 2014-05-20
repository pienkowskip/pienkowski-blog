class XML::Formatted::Elements::Root < XML::Formatted::Elements::Block
  ALLOWED_CHILDREN = [
      XML::Formatted::Elements::Paragraph,
      XML::Formatted::Elements::Header,
      XML::Formatted::Elements::Division,
      XML::Formatted::Elements::BlockQuote,
      XML::Formatted::Elements::HorizontalRule,
      XML::Formatted::Elements::List
  ]

  def validate(validator)
    result = validate_attrs validator
    result &= validate_rule validator, :not_root do
       self.equal? root
    end
    result &= validate_rule validator, :invalid_content do
      @children.all? do |child|
        ALLOWED_CHILDREN.any? { |klass| child.is_a?(klass) }
      end
    end
  end

  def render(renderer)
    "<div class=\"formatted\"#{render_attrs(renderer)}>#{render_content(renderer)}</div>"
  end
end