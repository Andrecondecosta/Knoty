class IndividualTasksController < ApplicationController

  def show
    @individual_task = IndividualTask.find(params[:id])
    @individual_challenge = @individual_task.individual_challenge
  end

  def create
    if @partner.created_by_invite? && @partner.invitation_accepted_at.nil?    # ==========> Set in PUNDIT
      return redirect_to quest_log_path, alert: "Your partner hasn't joined <em>Knoty</em> yet.".html_safe
    end
    return redirect_to quest_log_path, alert: "You have already started this challenge." if similar_task_exists?  # ==========> Set in PUNDIT

    @individual_challenge = IndividualChallenge.find(params[:individual_challenge_id])
    @individual_task = IndividualTask.new(date: individual_task_params[:date],
                                          individual_challenge: @individual_challenge,
                                          user: current_user,
                                          active: true)

    if @individual_task.save
      redirect_to individual_task_path(@individual_task), notice: "Challenge accepted!"
    else
      render "individual_challenges/show", status: :unprocessable_entity
    end
  end

  def mark_as_completed
    @individual_task = IndividualTask.find(params[:id])
    if @individual_task.update(completed: true)
      @couple.total_exp = 0 if @couple.total_exp.nil?
      @couple.total_exp += @individual_task.individual_challenge.exp
      @couple.save
      redirect_to home_path, notice: "Challenge completed!"
    else
      render :show, alert: "Something went wrong, please try again."
    end
  end

  private

  def individual_task_params
    params.require(:individual_task).permit(:date)
  end

  def similar_task_exists?
    IndividualTask.find_by(user: current_user, individual_challenge_id: params[:individual_challenge_id], completed: nil)
  end
end
