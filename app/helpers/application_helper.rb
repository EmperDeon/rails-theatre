module ApplicationHelper
    def api_server_path
        ENV['API_SERVER_PATH']
    end

    def get_img_path (name, p=false)
        "#{ api_server_path }#{ name }#{ p ? '-p' : '' }.png"
    end
end
