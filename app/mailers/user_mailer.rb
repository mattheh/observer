class UserMailer < ActionMailer::Base
  default from: "example@gmail.com"

  def mail_urls(user, urls)
    @user = user
    @urls = urls
    mail(to: @user.email, subject: 'New Craigslist Postings!')
  end
end

