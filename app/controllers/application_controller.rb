class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_mailer_host
  before_action :set_chatroom
  before_action :set_couple
  before_action :set_notifications
  before_action :set_pending_tasks
  before_action :set_current_score
  before_action :set_partner

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
    return unless couple

    @chatroom = couple.chatroom unless couple.nil?
  end

  def set_couple
    return unless user_signed_in?

    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
  end

  def set_notifications
    return unless user_signed_in?

    @notifications = current_user.notifications.unread
  end

  def set_pending_tasks
    return unless user_signed_in?

    couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    return unless couple

    @pending_tasks_notif = couple.couple_tasks.where(active: false)
                                 .select { |task| task.invited_id == current_user.id }.count
    puts "@pending_tasks_notif in ApplicationController: #{@pending_tasks_notif}"
    @pending_tasks = couple.couple_tasks.where(active: false)
  end

  def set_current_score
    return unless user_signed_in?

    couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    return unless couple

    @current_score = couple.total_exp
  end

  def set_partner
    return unless user_signed_in?

    couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    return unless couple

    @partner = couple.partner_1 == current_user ? couple.partner_2 : couple.partner_1
  end
end
