require 'test_helper'

class ConfigurationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get configuration_index_url
    assert_response :success
  end

  test "should get edit" do
    get configuration_edit_url
    assert_response :success
  end
end
