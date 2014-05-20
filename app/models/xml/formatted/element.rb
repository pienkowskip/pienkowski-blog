class XML::Formatted::Element < XML::Element
  include XML::Formatted::Validator::Helper

  def self.i18n_key
    self.name.underscore.gsub! /\//, '.'
  end

  def render(renderer)
    output = "<#{@name}#{render_attrs(renderer)}"
    if empty?
      output << ' />'
    else
      output << '>' << render_content(renderer) << "</#{@name}>"
    end
    output
  end

  def validate(validator)
    false #because this class is abstract
  end

  protected

  def render_content(renderer)
    output = ''
    @children.each { |child| output << child.render(renderer) }
    output
  end

  def render_attrs(renderer)
    (@attrs.map { |attr, value| " #{attr}=\"#{ERB::Util.html_escape(value)}\"" }).join('')
  end
end