class MissionsController < ApplicationController
  before_action :set_pending_tasks, only: %i[index edit]

  def index
    @missions = current_user.missions
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = current_user.missions.build(mission_params.merge(exp: 10, completed: false))
    if @mission.save
      redirect_to missions_path, notice: 'Mission was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @mission = Mission.find(params[:id])
  end

  def update
    @mission = Mission.find(params[:id])
    if @mission.update(mission_params)
      redirect_to missions_path, notice: 'Mission was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.mission_count.to_i < 4
      current_user.mission_count += 1
    else
      current_user.mission_count = 0
    end
    current_user.save
    @mission = Mission.find(params[:id])
    @mission.destroy
    redirect_to missions_path, notice: 'Mission was successfully completed.'
  end

  private

  def mission_params
    params.require(:mission).permit(:title, :details, :icon)
  end

  def set_pending_tasks
    return unless signed_in?

    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    @pending_tasks = @couple.couple_tasks.where(active: false)
    @pending_tasks_notif = @couple.couple_tasks.where(active: false).select { |task| task.invited_id == current_user.id }
  end
end
