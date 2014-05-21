class XML::Formatted::Elements::BlockQuote < XML::Formatted::Elements::Block
  def validate(validator)
    result = validate_attrs validator
    result &= validate_rule validator, :invalid_content do
      @children.all? do |child|
        XML::Formatted::Elements::Root::ALLOWED_CHILDREN.any? { |klass| child.is_a?(klass) }
      end
    end
  end

  def size
    2
  end
end