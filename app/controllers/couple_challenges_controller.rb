class CoupleChallengesController < ApplicationController

  def show
    @couple_challenge = CoupleChallenge.find(params[:id])
    @couple_task = CoupleTask.new
  end
end
