class IndividualTasksController < ApplicationController



  private

  def set_pending_tasks
    return unless signed_in?

    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    @pending_tasks = @couple.couple_tasks.where(active: false)
    @pending_tasks_notif = @couple.couple_tasks.where(active: false).select { |task| task.invited_id == current_user.id }
  end
end
