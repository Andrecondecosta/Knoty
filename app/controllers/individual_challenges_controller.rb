class IndividualChallengesController < ApplicationController


  def show
    @individual_challenge = IndividualChallenge.find(params[:id])
  end
end
