class Admin::DirectoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, nil, {user_id: 2}
    assert_response :success
    assert_not_nil assigns(:directories)
    assert_not_nil assigns(:counts)
  end
end