class CoupleChallengesController < ApplicationController

  def show
    @couple_challenge = CoupleChallenge.find(params[:id])
  end
end
