module ApplicationHelper
	def img_server_path
		ENV['IMG_SERVER_PATH'] + 'img'
	end

	def api_server_path
		ENV['API_SERVER_PATH']
	end

	def get_img_path (name, p=false)
		"#{ img_server_path }/#{ name }#{ p ? '-p' : '' }.png"
	end

	def get_hall_path (id)
		"/utils/hall_preview/#{Poster.find(id).t_perf.t_hall_id}/#{id}"
	end
end
