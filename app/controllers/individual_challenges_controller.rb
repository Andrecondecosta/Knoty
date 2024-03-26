class IndividualChallengesController < ApplicationController
  before_action :set_pending_tasks, only: %i[show]

  def show
    @individual_challenge = IndividualChallenge.find(params[:id])
    @individual_task = IndividualTask.new

    if current_user.individual_tasks.any? {|task| task.individual_challenge == @individual_challenge} # ========> Set in Pundit
      return redirect_to explore_solo_challenges_path, alert: 'This solo challenge is already active!'
    end
  end

  private

  def set_pending_tasks
    return unless signed_in?

    @pending_tasks = @couple.couple_tasks.where(active: false)
    @pending_tasks_notif = @couple.couple_tasks.where(active: false).select { |task| task.invited_id == current_user.id }
  end
end
