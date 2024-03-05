class NotifierMailer < ApplicationMailer
  def new_account(recipient)
    mail(to: recipient, subject: 'Welcome to My Awesome Site')
  end
end
