class CoupleTasksController < ApplicationController
  before_action :set_couple, only: %i[show edit create mark_as_completed]
  before_action :set_partner, only: %i[show create]
  before_action :set_pending_tasks, only: %i[show]
  before_action :set_invited_partner, only: %i[show edit]

  def show
    @couple_challenge = @couple.couple_challenges.find(@couple_task.couple_challenge_id)
  end

  def create
    if @partner.created_by_invite? && @partner.invitation_accepted_at.nil?    # ==========> Set in PUNDIT
      return redirect_to quest_log_path, alert: "Your partner has not accepted the invitation yet."
    end
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

  def edit
    if current_user != @invited_partner || @couple_task.active == true # ==========> Set in PUNDIT
      return redirect_to quest_log_path
    end

    @couple_challenge = @couple.couple_challenges.find(@couple_task.couple_challenge_id)
  end

  def update
    if @couple_task.update(completion_date: params[:options])
      @couple_task.active = true
      @couple_task.save
      redirect_to @couple_task, notice: "Challenge Activated!"
    else
      render :edit, alert: "Something went wrong, please try again."
    end
  end

  def mark_as_completed
    @couple_task = CoupleTask.find(params[:id])
    if @couple_task.update(completed: true)
      @couple.total_exp = 0 if @couple.total_exp.nil?
      @couple.total_exp += @couple_task.couple_challenge.exp
      @couple.save
      redirect_to root_path, notice: "Challenge completed!"
    else
      render :show, alert: "Something went wrong, please try again."
    end
  end

  private

  def couple_task_params
    params.require(:couple_task).permit(:date_option_1, :date_option_2, :date_option_3, :completion_date)
  end

  def set_couple_task
    @couple_task = CoupleTask.find(params[:id])
  end

  def set_partner
    @partner = @couple.partner_1 == current_user ? @couple.partner_2 : @couple.partner_1
  end

  def similar_task_exists?
    CoupleTask.find_by(couple_challenge_id: params[:couple_challenge_id], couple: @couple, completed: nil)
  end

  def set_pending_tasks
    return unless signed_in?

    @pending_tasks = @couple.couple_tasks.where(active: false)
    @pending_tasks_notif = @couple.couple_tasks.where(active: false).select { |task| task.invited_id == current_user.id }
  end

  def set_invited_partner
    @couple_task = CoupleTask.find(params[:id])
    @invited_partner = User.find(@couple_task.invited_id)
  end
end
