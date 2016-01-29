module UserHostApplicationJob
  @queue = :mail
  
  def self.perform(user, message)
    # user = User.find(id)
    UserMailer.send_host_application(user, message).deliver
  end

end
