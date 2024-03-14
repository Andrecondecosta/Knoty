class IndividualTasksController < ApplicationController
  before_action :set_couple, only: %i[create]
  before_action :set_partner, only: %i[create]

  def show
    @individual_task = IndividualTask.find(params[:id])
    @individual_challenge = @individual_task.individual_challenge
  end

  def create
    if @partner.created_by_invite? && @partner.invitation_accepted_at.nil?    # ==========> Set in PUNDIT
      return redirect_to quest_log_path, alert: "Your partner has not accepted the invitation yet."
    end
    return redirect_to quest_log_path, alert: "You have already started this challenge." if similar_task_exists?  # ==========> Set in PUNDIT

    @individual_challenge = IndividualChallenge.find(params[:individual_challenge_id])
    @individual_task = IndividualTask.new
    @individual_task.individual_challenge = @individual_challenge
    @individual_task.user = current_user
    @individual_task.active = true
    if @individual_task.save
      redirect_to individual_task_path(@individual_task), notice: "Challenge accepted!"
    else
      render "individual_challenges/show", alert: "Something went wrong, please try again."
    end
  end

  private

  def set_couple
    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
  end

  def similar_task_exists?
    IndividualTask.find_by(user: current_user, individual_challenge_id: params[:individual_challenge_id], active: true)
  end

  def set_partner
    @partner = @couple.partner_1 == current_user ? @couple.partner_2 : @couple.partner_1
  end

  def set_pending_tasks
    return unless signed_in?

    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    @pending_tasks = @couple.couple_tasks.where(active: false)
    @pending_tasks_notif = @couple.couple_tasks.where(active: false).select do |task|
      task.invited_id == current_user.id
    end
  end
end
