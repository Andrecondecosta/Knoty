class MissionsController < ApplicationController
  def index
    @missions = current_user.missions
  end

  def new
    @mission = Mission.new
  end

  def show
    @mission = Mission.find(params[:id])
  end

  def create
    @mission = current_user.missions.build(mission_params.merge(exp: 10, completed: false))
    if @mission.save
      redirect_to missions_path, notice: 'Mission was successfully created.'
    else
      render :new
    end
  end

  def complete
    @mission = Mission.find(params[:id])
    @mission.destroy
    redirect_to missions_path, notice: 'Mission was successfully completed.'
  end

  private

  def mission_params
    params.require(:mission).permit(:title, :details, :icon)
  end
end
