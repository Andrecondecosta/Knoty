class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home landing]
  before_action :set_active_tasks, only: %i[quests couples_challenges_in_progress]
  before_action :set_partner, only: %i[home profile quests solo_challenges_in_progress couples_challenges_in_progress explore_couples_challenges]
  before_action :set_couple_challenges, only: %i[quests explore_couples_challenges]
  before_action :set_individual_challenges, only: %i[quests explore_solo_challenges]

  def home
    # raise
    # this defines the progress value on the progress bar:
    # NOTE CHANGE HERE TO 1-5
    # 1=0%
    # 2=33%
    # 3=66%
    # 4=100%
    @current_score = @couple.total_exp if user_signed_in? && @couple
  end

  def landing
    return redirect_to home_path if user_signed_in? # ===============> set in Pundit
  end

  def quests
    # current_user solo tasks
    @my_solo_tasks = current_user.individual_tasks.where(completed: nil)

    # partner solo tasks
    @partner_solo_tasks = @partner.individual_tasks.where(completed: nil) if @partner
  end

  # ---------------------------- LINK OPTIONS IN THE QUEST LOG ----------------------------
  def explore_couples_challenges
  end

  def explore_solo_challenges

  end

  def solo_challenges_in_progress
    @my_solo_tasks = current_user.individual_tasks.where(completed: nil)
    @partner_solo_tasks = @partner.individual_tasks.where(completed: nil) if @partner
  end

  def couples_challenges_in_progress
  end

  #-------------------------------- PROFILE PAGE --------------------------------

  def profile
    @my_love_language = define_love_language(current_user.love_language) if current_user.love_language
    @partner_love_language = define_love_language(@partner.love_language) if @partner.love_language
  end

  private

  def set_partner
    return unless user_signed_in? && @couple

    @partner = @couple.partner_1 == current_user ? @couple.partner_2 : @couple.partner_1
  end

  def set_active_tasks
    return unless user_signed_in? && @couple

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
    filtered_solo_chals = IndividualChallenge.joins(:individual_tasks)
                                             .where.not(individual_tasks: { user_id: current_user.id })
                                             .select do |chal|
      chal.individual_tasks.where(user_id: current_user.id).empty?
    end
    @individual_challenges = open_solo_chals + filtered_solo_chals
  end
end
