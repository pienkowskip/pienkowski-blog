ActionView::Helpers::FormBuilder.class_eval do
  [:text_field, :email_field, :text_area].each do |type|
    define_method :"labeled_#{type}", ->(method, label_text = nil, options = {}) do
      labeled_field type, method, label_text, options
    end
  end

  private
  def labeled_field(ftype, method, label_text = nil, options = {})
    label(method, label_text) + send(ftype, method, options)
  end
end

ActionView::Helpers::Tags::Base.class_eval do
  def select_content_tag_with_prompt(option_tags, options, html_options)
    if options[:prompt]
      option_tags = content_tag_string('option', prompt_text(options[:prompt]), {
          value: '',
          selected: true,
          disabled: true,
          style: 'display:none'
      }) + "\n" + option_tags
      options.delete(:prompt)
    end
    select_content_tag_without_prompt(option_tags, options, html_options)
  end

  alias_method_chain :select_content_tag, :prompt
end