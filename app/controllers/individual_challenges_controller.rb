class IndividualChallengesController < ApplicationController
  before_action :set_pending_tasks, only: %i[show]

  def show
    @individual_challenge = IndividualChallenge.find(params[:id])
  end

  private

  def set_pending_tasks
    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    @pending_tasks = @couple.couple_tasks.where(active: false).select { |task| task.invited_id == current_user.id }
  end
end
