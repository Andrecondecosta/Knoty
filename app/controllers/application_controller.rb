class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_mailer_host
  before_action :set_chatroom
  before_action :set_couple

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name nickname birth_date gender avatar_url])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name nickname birth_date gender
                                                                avatar_url])
  end

  private

  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def set_chatroom
    return unless user_signed_in?

    couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    @chatroom = couple.chatroom
  end

  def set_couple
    return unless user_signed_in?

    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
  end
end
