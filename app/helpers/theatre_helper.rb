module TheatreHelper
  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: {rel: 'nofollow', target: '_blank'},
      space_after_headers: true,
      fenced_code_blocks: true
    }

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)

    html = markdown.render(text) #.html_safe
    # html.gsub(/<.*>/, '_')
  end
end
