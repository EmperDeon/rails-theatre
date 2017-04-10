module TheatreHelper
	def markdown (text)
		options = {
			filter_html: true,
			hard_wrap: true,
			link_attributes: {rel: 'nofollow', target: '_blank'},
			space_after_headers: true,
			fenced_code_blocks: true
		}

		extensions = {
			autolink: true,
			superscript: true,
			disable_indented_code_blocks: true
		}

		renderer = Redcarpet::Render::HTML.new(options)
		markdown = Redcarpet::Markdown.new (Redcarpet::Render::HTML.new)

		html = markdown.render(text) #.html_safe
		# html.gsub(/<.*>/, '_')
	end
end
