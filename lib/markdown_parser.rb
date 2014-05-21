class MarkdownParser
  include Singleton

  def parse(markdown)
    @parser.render(markdown)
  end

  private

  def initialize
    @parser = Redcarpet::Markdown.new(
        Redcarpet::Render::XHTML.new(),
        disable_indented_code_blocks: true,
        strikethrough: true,
        underline: true)
  end
end