require_relative '../../db/love_language_questionnaire'

class LoveLanguagesController < ApplicationController
  def new
    redirect_to root_path if current_user.love_language         # ==========> Set in PUNDIT
    @love_language_questionnaire = LOVE_LANGUAGE_QUESTIONNAIRE_SHORT
    @number_of_questions = @love_language_questionnaire.size
    @love_language = LoveLanguage.new
  end

  def create
    redirect_to root_page if current_user.love_language    # ==========> Set in PUNDIT
    @love_language = LoveLanguage.new(love_language_params)
    @love_language.user = current_user
    if @love_language.save!
      redirect_to profile_path, notice: "Your love language has been saved!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def love_language_params
    params.require(:love_language).permit(:acts_of_service, :words_of_affirmation, :receiving_gifts, :quality_time, :physical_touch)
  end
end
