module ApplicationHelper
	def api_server_path
		ENV['API_SERVER_PATH']
	end

	def get_img_path (name, p=false)
		"#{ api_server_path }img/#{ name }#{ p ? '-p' : '' }.png"
	end

	def get_hall_path (id)
		"#{ api_server_path }utils/hall_preview?id=#{id}"
	end
end
