class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :set_couple, only: %i[profile]
  before_action :set_pending_tasks, only: %i[home profile quests]

  def home
  end

  def quests
    @couple_challenges = CoupleChallenge.all
    @individual_challenges = IndividualChallenge.all
  end

  def profile
    @partner = current_user == @couple.partner_1 ? @couple.partner_2 : @couple.partner_1
  end

  private

  def set_couple
    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
  end

  def set_pending_tasks
    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    @pending_tasks = @couple.couple_tasks.where(active: false).select { |task| task.invited_id == current_user.id }
  end
end
