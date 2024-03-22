class UsersController < ApplicationController
  def edit_profile
    @user = current_user
  end

  def edit_existing_profile
    @user = current_user
  end

  def update_existing_profile
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Profile updated successfully'
    else
      render :edit_existing_profile
    end
  end

  def update_profile
    @user = current_user
    if @user.update(user_params)
      generate_audio_mp3 if @couple.partner_2 == current_user
      redirect_to new_love_language_path
    else
      render :edit_profile, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :date_of_birth, :avatar_url)
  end

  def generate_audio_mp3
    client = OpenAI::Client.new
    response = client.audio.speech(
      parameters: {
        model: "tts-1",
        input: story,
        voice: "onyx"
      }
    )

    @couple.audio.attach(io: StringIO.new(response, 'rb'), filename: "couple_#{@couple.id}.mp3")
  end

  def story
    "It wasn’t soon until the news arrived at
    #{@couple.partner_1.first_name && @couple.partner_2.first_name ? "#{@couple.partner_1.first_name} and #{@couple.partner_2.first_name}'s": "the heroes'"}
    house. Long
    before that day, they’d only heard of it in ancient tales. From time to time, in
    the village, couples claimed that they had encountered these feared
    creatures. However, as no one else could see them except for the couples
    themselves, they were often dismissed as figments of their own imagination.
    Yet, this time was different.
    Boredoom and his faithful henchman, Chorebrutus, had been viciously
    spreading their venom among couples from nearby villages. Stealthily
    prowling through the surrounding communities, they sowed chaos and fear
    among the couples. Boredoom was determined to tear every couple apart,
    revelling in the malicious pride of being the orchestrator of love’s downfall.
    Anca and Ahmed had been living in Heartshire since they fell in love. Having
    a kind and thoughtful way with each other, both being dreamers and eager
    to build their lives together, they embarked on each day with commitment
    and devotion. Now, to protect their love, they would have to confront the
    looming threat of Boredoom and Chorebrutus.
    Determined to protect their love against these malevolent forces, Anca and
    Ahmed sought guidance from an elder, known to be the sole survivor of a
    couple whose love had withstood the trials imposed by these creatures.
    The elder, a venerable figure with eyes that seemed to hold centuries of
    wisdom, explained that Boredoom and Chorebrutus were embodiments of
    discord and envy and thrived on the pain and suffering they caused. Legend
    had it that the key to defeating these creatures lay hidden within the seven
    islands of Venus Archipelago. It was said that on each island, a different type
    of love seed flourished, possessing unparalleled strength and resilience.
    Once nurtured and cared for daily, these seeds possessed the remarkable
    ability to render the creatures to insignificance, causing them to shrink and
    ultimately disintegrate into ashes.
    Driven by the hope ignited by this legend, Anca and Ahmed resolved to
    embark on a journey to Venus Archipelago. They knew that only by finding
    and harnessing the power of these extraordinary seeds could they vanquish
    the malevolent forces threatening their love."
  end
end
