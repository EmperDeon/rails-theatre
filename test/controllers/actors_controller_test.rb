require 'test_helper'

class ActorsControllerTest < ActionDispatch::IntegrationTest
	test "should get index" do
		get actors_index_url
		assert_response :success
	end

	test "should get show" do
		get actors_show_url
		assert_response :success
	end

end
