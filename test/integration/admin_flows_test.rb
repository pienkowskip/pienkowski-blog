require 'test_helper'

class AdminFlowsTest < ActionDispatch::IntegrationTest
  include UserTestHelper

  test 'login and add a directory' do
    # Access user login page
    get '/user/login'
    assert_response :success
    # Login as admin
    post_via_redirect '/user/login', login: users(:default).username, password: default_user.password
    assert_equal '/admin', path
    # Access directories
    get '/admin/directories'
    assert_response :success
    assert assigns(:directories)
  end
end
