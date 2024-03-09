class CoupleChallengesController < ApplicationController

  def show
    @couple_challenge = CoupleChallenge.find(params[:id])
    @couple_task = CoupleTask.new
  end

  private

  def set_couple
    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
  end

  def set_partner
    @partner = @couple.partner_1 == current_user ? @couple.partner_2 : @couple.partner_1
  end
end
