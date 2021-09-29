module Public::MarkdownHelper
  def markdown(world_body)
    options = {
      filter_html: true,
      hard_wrap: true,
      space_after_headers: true,
      with_toc_data: true
    }

    extensions = {
      lax_spacing: true,
      strikethrough: true,
      superscript: true,
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      tables: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(world_body).html_safe
  end
end