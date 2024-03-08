class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def quests
    @couple_challenge = CoupleChallenge.all
    @individual_challenge = IndividualChallenge.all
  end
end
