class Guest::TestController < Guest::AbstractController
  class RecursiveRenderer < Redcarpet::Render::XHTML
    def block_html(raw_html)
      if (md = raw_html.match(/\<(.+?)\>(.*)\<(\/.+?)\>/m))
        open_tag, content, close_tag = md.captures
        "\n<#{open_tag}>\n#{render content}<#{close_tag}>\n"
      else
        raw_html
      end
    end

    def set_render(&block)
      @render = block
    end

    private
    def render(markdown)
      if @render.nil?
        markdown
      else
        @render.call(markdown)
      end
    end
  end

  def index
    @result = params[:input]
  end
end
