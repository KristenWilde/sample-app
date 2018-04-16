require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new user page" do
    get signup_path
    assert_response :success
    assert_select "title", "Sign up | Sample App" 
  end

end
