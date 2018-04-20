require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:juli)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "name should not be too long"  do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + '@example.com'
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER3@foo.COM A_US-ER@foo.bar.org
                        first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com USER3.foo.COM A_US-ER@foo.
                        first@foo_bar.jp bob@baz+aj.cn foo@bar..com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email.upcase!
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAmple.COM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present and nonblank" do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end


end
