class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :set_couple, only: %i[home profile quests]
  before_action :set_pending_tasks, only: %i[home profile quests]
  before_action :set_active_tasks, only: %i[quests]
  before_action :set_partner, only: %i[home profile quests]
  before_action :set_couple_challenges, only: %i[quests]
  before_action :set_individual_challenges, only: %i[quests]

  def home
    # this defines the progress value on the progress bar:
    # NOTE CHANGE HERE TO 1-5
    # 1=20%
    # 2=40%
    # 3=60%
    # 4=80%
    # 5=100%
    @current_score = @couple.total_exp if signed_in?
  end

  def quests
    # current_user solo tasks
    @my_solo_tasks = current_user.individual_tasks.where(completed: nil)

    # partner solo tasks
    @partner_solo_tasks = @partner.individual_tasks.where(completed: nil) if @partner
  end

  def profile
    @my_love_language = define_love_language(current_user.love_language) if current_user.love_language
    @partner_love_language = define_love_language(@partner.love_language) if @partner.love_language
  end

  private

  def set_couple
    return unless signed_in?

    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
  end

  def set_partner
    return unless signed_in?

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
    @active_tasks = @couple.couple_tasks.where(active: true, completed: nil)
  end

  def define_love_language(l_l_result)
    {
      'Acts of service': l_l_result.acts_of_service,
      'Words of affirmation': l_l_result.words_of_affirmation,
      'Receiving gifts': l_l_result.receiving_gifts,
      'Quality time': l_l_result.quality_time,
      'Physical touch': l_l_result.physical_touch
    }
  end

  def set_couple_challenges
    # All couple challenges that are not completed
    open_cpl_chals = CoupleChallenge.left_outer_joins(:couple_tasks).where(couple_tasks: { id: nil })
    filtered_cpl_chals = CoupleChallenge.joins(:couple_tasks).where.not(couple_tasks: { couple_id: @couple.id })
                                        .select do |chal|
      chal.couple_tasks.where(couple_id: @couple.id).empty?
    end
    @couple_challenges = open_cpl_chals + filtered_cpl_chals
  end

  def set_individual_challenges
    # All solo challenges that are not completed
    open_solo_chals = IndividualChallenge.left_outer_joins(:individual_tasks).where(individual_tasks: { id: nil })
    filtered_solo_chals = IndividualChallenge.joins(:individual_tasks).where.not(individual_tasks: { user_id: current_user.id })
                                             .select do |chal|
      chal.individual_tasks.where(user_id: current_user.id).empty?
    end
    @individual_challenges = open_solo_chals + filtered_solo_chals
  end
end
