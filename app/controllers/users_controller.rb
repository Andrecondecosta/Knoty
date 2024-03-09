class UsersController < ApplicationController

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(user_params)
      redirect_to new_love_language_path
    else
      render :edit_profile, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :date_of_birth, :avatar_url)
  end
end
