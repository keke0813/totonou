require "test_helper"

class Public::PostSaunasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_post_saunas_new_url
    assert_response :success
  end

  test "should get index" do
    get public_post_saunas_index_url
    assert_response :success
  end

  test "should get show" do
    get public_post_saunas_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_post_saunas_edit_url
    assert_response :success
  end
end
