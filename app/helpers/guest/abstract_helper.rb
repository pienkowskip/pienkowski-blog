module Guest::AbstractHelper
  def category_name(text_id)
    @categories_names = Hash[Category.order(:text_id).pluck(:text_id, :name)] unless defined? @categories_names
    @categories_names[text_id]
  end

  def capitalize(string)
    if string.is_a?(String)
      string.mb_chars.capitalize.to_s
    else
      string
    end
  end
end