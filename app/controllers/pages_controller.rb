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
    @my_love_language = set_love_language(current_user.love_language) if current_user.love_language
    @partner_love_language = set_love_language(@partner.love_language) if @partner.love_language
  end

  private

  def set_couple
    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
  end

  def set_pending_tasks
    return unless signed_in?

    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    @pending_tasks = @couple.couple_tasks.where(active: false).select { |task| task.invited_id == current_user.id }
  end

  def set_love_language(l_l_result)

    {"Acts of service": l_l_result.acts_of_service, "Words of affirmation": l_l_result.words_of_affirmation, "Receiving gifts": l_l_result.receiving_gifts, "Quality time": l_l_result.quality_time, "Physical touch": l_l_result.physical_touch }
  end
end
