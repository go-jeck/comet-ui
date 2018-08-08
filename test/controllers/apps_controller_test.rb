require 'test_helper'

class AppsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get apps_path_url
    assert_response :success
  end

end
