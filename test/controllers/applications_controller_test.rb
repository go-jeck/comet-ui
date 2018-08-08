require 'test_helper'

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get applications_path_url
    assert_response :success
  end

end
