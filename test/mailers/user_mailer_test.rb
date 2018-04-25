require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:zach)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)

    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name,              mail.body.encoded
    assert_match user.activation_token,  mail.body.encoded
    assert_match ERB::Util.url_encode(user.email), mail.body.encoded
    # CGI.escape(str) does the same thing as ERB::Util.url_encode(str).
  end


  # test "password_reset" do
  #   mail = UserMailer.password_reset
  #   assert_equal "Password reset", mail.subject
  #   assert_equal ["to@example.org"], mail.to
  #   assert_equal ["from@example.com"], mail.from
  #   assert_match "Hi", mail.body.encoded
  # end

end
