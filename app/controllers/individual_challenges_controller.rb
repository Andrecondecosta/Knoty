class IndividualChallengesController < ApplicationController

  def show
    @individual_challenge = IndividualChallenge.find(params[:id])
    @individual_task = IndividualTask.new

    if current_user.individual_tasks.any? {|task| task.individual_challenge == @individual_challenge} #==> Set in Pundit
      return redirect_to explore_solo_challenges_path, alert: 'This solo challenge is already active!'
    end
  end
end
