class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def quests
    @couple_challenges = CoupleChallenge.all
    @individual_challenges = IndividualChallenge.all
  end

  def profile
    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    @partner = current_user == @couple.partner_1 ? @couple.partner_2 : @couple.partner_1
  end
end
