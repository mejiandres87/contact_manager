require "test_helper"

class ContactsFilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get contacts_files_index_url
    assert_response :success
  end

  test "should get new" do
    get contacts_files_new_url
    assert_response :success
  end

  test "should get show" do
    get contacts_files_show_url
    assert_response :success
  end

  test "should get create" do
    get contacts_files_create_url
    assert_response :success
  end
end
