require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get redirect" do
    get home_redirect_url
    assert_response :success
  end
end
