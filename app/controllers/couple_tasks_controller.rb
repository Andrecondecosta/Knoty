class CoupleTasksController < ApplicationController
  before_action :set_couple, only: %i[show create]
  before_action :set_partner, only: %i[show create]
  before_action :set_pending_tasks, only: %i[show]

  def show
    @couple_task = CoupleTask.find(params[:id])
    @couple_challenge = @couple.couple_challenges.find(@couple_task.couple_challenge_id)
  end

  def create
    if @partner.created_by_invite? && @partner.invitation_accepted_at.nil?
      return redirect_to quest_log_path, alert: "Your partner has not accepted the invitation yet."
    end   # ==========> Set in PUNDIT
    return redirect_to quest_log_path, alert: "You have already started this challenge." if similar_task_exists?  # ==========> Set in PUNDIT

    @couple_task = CoupleTask.new(couple_task_params)
    @couple_task.couple_challenge_id = params[:couple_challenge_id]
    @couple_task.couple = @couple
    @couple_task.invited_id = @partner.id
    @couple_task.active = false
    if @couple_task.save!
      redirect_to @couple_task, notice: "Challenge started!"
    else
      render 'couple_challenges/show', alert: "Something went wrong, please try again."
    end
  end

  private

  def couple_task_params
    params.require(:couple_task).permit(:date_option_1, :date_option_2, :date_option_3)
  end

  def set_couple
    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
  end

  def set_partner
    @partner = @couple.partner_1 == current_user ? @couple.partner_2 : @couple.partner_1
  end

  def similar_task_exists?
    @couple_task = CoupleTask.find_by(couple_challenge_id: params[:couple_challenge_id])
  end

  def set_pending_tasks
    return unless signed_in?

    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    @pending_tasks = @couple.couple_tasks.where(active: false)
    @pending_tasks_notif = @couple.couple_tasks.where(active: false).select { |task| task.invited_id == current_user.id }
  end
end
