class UserMailer < ActionMailer::Base
  include Resque::Mailer
  default from: "admin@nommery.com"
  default to: "Melisa@SFFoodies.com"

  def send_host_application(user_id, message)
    @user = User.find(user_id.to_i)
    @message = message
    mail(to: "Melisa@SFFoodies.com", cc: "the.rain.monster@gmail.com", subject: "testing") #stubbed
  end
end
