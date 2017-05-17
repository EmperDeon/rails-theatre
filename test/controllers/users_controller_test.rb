require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	test "should get favorites" do
		get users_favorites_url
		assert_response :success
	end

end
