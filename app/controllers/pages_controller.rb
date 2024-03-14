class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :set_couple, only: %i[profile]
  before_action :set_pending_tasks, only: %i[home profile quests]
  before_action :set_active_tasks, only: %i[quests]
  before_action :set_partner, only: %i[profile quests]

  def home
  end

  def quests
    # All couple challenges that are not completed
    # needs to be fixed (retrieves couple challenges that are completed by anyone not exclusively the couple)
    @couple_challenges = CoupleChallenge.left_outer_joins(:couple_tasks).where(couple_tasks: { id: nil })

    # All solo challenges that are not completed
    # needs to be fixed (retrieves solo challenges that are completed by anyone not exclusively the couple)
    @individual_challenges = IndividualChallenge.left_outer_joins(:individual_tasks).where(individual_tasks: { id: nil })

    # current_user solo tasks
    @my_solo_tasks = current_user.individual_tasks

    # partner solo tasks
    @partner_solo_tasks = @partner.individual_tasks if @partner
  end

  def profile
    @my_love_language = define_love_language(current_user.love_language) if current_user.love_language
    @partner_love_language = define_love_language(@partner.love_language) if @partner.love_language
  end

  private

  def set_couple
    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
  end

  def set_partner
    @partner = @couple.partner_1 == current_user ? @couple.partner_2 : @couple.partner_1
  end

  def set_pending_tasks
    return unless signed_in?

    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    @pending_tasks_notif = @couple.couple_tasks.where(active: false).select { |task| task.invited_id == current_user.id }
    @pending_tasks = @couple.couple_tasks.where(active: false)
  end

  def set_active_tasks
    return unless signed_in?

    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
    @active_tasks = @couple.couple_tasks.where(active: true)
  end

  def define_love_language(l_l_result)
    {"Acts of service": l_l_result.acts_of_service, "Words of affirmation": l_l_result.words_of_affirmation, "Receiving gifts": l_l_result.receiving_gifts, "Quality time": l_l_result.quality_time, "Physical touch": l_l_result.physical_touch }
  end
end
