require "test_helper"

class ContactsFileTest < ActiveSupport::TestCase
  test "File name must exist" do
    @contacts_file = ContactsFile.new()
    assert_not @contacts_file.valid?
  end

  test "File must belong to a user" do
    @contacts_file = ContactsFile.new(name: "file name")
    assert_not @contacts_file.valid?
  end

  test "Status must exist" do
    @contacts_file = ContactsFile.new(name: "file name", user: User.first)
    assert @contacts_file.valid?
  end

  test "Contacts file is valid" do
    @contacts_file = ContactsFile.new(name: "Filename", user: User.first)
    assert @contacts_file.valid?
  end
end
