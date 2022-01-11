require "test_helper"

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Name should be valid" do
    @user = User.first
    @contact = Contact.new(name: '%', birthdate: Date.new(1987, 5, 19),
                          phone_number: '(+57) 310 477 07 18', address: 'Cra 11 # 95 - 37',
                          cc_mask: '4111111111111111', email: 'test@email.com', user: @user)
    assert_not @contact.valid?
  end

  test "Phone number should be valid" do
    @user = User.first
    @contact = Contact.new(name: 'Valid name', birthdate: Date.new(1987, 5, 19),
                          phone_number: '(+57)3104770718', address: 'Cra 11 # 95 - 37',
                          cc_mask: '4111111111111111', email: 'test@email.com', user: @user)
    assert_not @contact.valid?
  end

  test "Address must not be blank" do
    @user = User.first
    @contact = Contact.new(name: 'Valid name', birthdate: Date.new(1987, 5, 19),
                          phone_number: '(+57) 310 477 07 18', address: ' ',
                          cc_mask: '4111111111111111', email: 'test@email.com', user: @user)
    assert_not @contact.valid?
  end

  test "Credit card info must be valid" do
    @user = User.first
    @contact = Contact.new(name: 'Valid name', birthdate: Date.new(1987, 5, 19),
                          phone_number: '(+57) 310 477 07 18', address: 'Cra 11 # 95 - 37',
                          cc_mask: '251111111', email: 'test@email.com', user: @user)
    assert_not @contact.valid?
  end

  test "Email must be valid" do
    @user = User.first
    @contact = Contact.new(name: 'Valid name', birthdate: Date.new(1987, 5, 19),
                          phone_number: '(+57) 310 477 07 18', address: 'Cra 11 # 95 - 37',
                          cc_mask: '4111111111111111', email: 'invalid email', user: @user)
    assert_not @contact.valid?
  end

  test "Contact email must be unique for user" do
    @user = User.first
    temp_contact =Contact.create(name: 'Valid name', birthdate: Date.new(1987, 5, 19),
                              phone_number: '(+57) 310 477 07 18', address: 'Cra 11 # 95 - 37',
                              cc_mask: '4111111111111111', email: 'test@email.com', user: @user)
    @contact = Contact.new(name: 'Valid name', birthdate: Date.new(1987, 5, 19),
                          phone_number: '(+57) 310 477 07 18', address: 'Cra 11 # 95 - 37',
                          cc_mask: '4111111111111111', email: 'test@email.com', user: @user)
    assert_not @contact.valid?
  end

  test "Contact is valid" do
    @user = User.first
    @contact = Contact.new(name: 'Valid name', birthdate: Date.new(1987, 5, 19),
                          phone_number: '(+57) 310 477 07 18', address: 'Cra 11 # 95 - 37',
                          cc_mask: '4111111111111111', email: 'test@email.com', user: @user)
    assert @contact.valid?
  end
end
