class Userregistration < ActionMailer::Base
    default from: "noreply@musicmelter.com"


  def user_registration_receipt(user)
    @user = user
    mail(:to => @user.email, :subject => "Your pre-registration on MusicMelter.com")
  end

end
