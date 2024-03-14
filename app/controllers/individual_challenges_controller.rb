class IndividualChallengesController < ApplicationController
  before_action :set_pending_tasks, only: %i[show]

  def show
    @individual_challenge = IndividualChallenge.find(params[:id])
    @individual_task = IndividualTask.new
  end

  private

  def set_couple
    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
  end

  def set_pending_tasks
    return unless signed_in?

    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    @pending_tasks = @couple.couple_tasks.where(active: false)
    @pending_tasks_notif = @couple.couple_tasks.where(active: false).select { |task| task.invited_id == current_user.id }
  end
end
