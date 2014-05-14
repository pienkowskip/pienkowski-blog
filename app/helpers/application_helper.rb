module ApplicationHelper
  def has_params?(rules={})
    rules.each do |name, value|
      if value.is_a? Regexp
        return false unless params[name] =~ value
      else
        return false unless params[name] == value
      end
    end
    true
  end

  def subtitle(title)
    content_for(:subtitle) { title }
  end
end
