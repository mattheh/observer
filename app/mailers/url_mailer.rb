class URLMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'
end
