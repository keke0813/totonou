require "test_helper"

class Admin::PostSaunasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_post_saunas_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_post_saunas_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_post_saunas_edit_url
    assert_response :success
  end
end
