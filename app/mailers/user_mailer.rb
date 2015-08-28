class UserMailer < ActionMailer::Base
  default from: "example@gmail.com"

  def mail_urls(user)
    @user = user
    #@url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end

