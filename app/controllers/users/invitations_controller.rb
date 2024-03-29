class Users::InvitationsController < Devise::InvitationsController

  # GET /resource/invitation/new
  def new
    return redirect_to home_path if current_user.couple_as_partner_1 || current_user.couple_as_partner_2 # ==========> Set in PUNDIT

    self.resource = resource_class.new
    render :new
  end

  # POST /resource/invitation
  def create
    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    if resource_invited
      # Create a Couple instance & memory Event if the invite was successful
      create_couple

      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, email: self.resource.email
      end
      respond_with resource, location: edit_profile_path
    else
      respond_with(resource)
    end
  end

  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    self.resource = accept_resource
    invitation_accepted = resource.errors.empty?

    yield resource if block_given?

    if invitation_accepted
      if resource.class.allow_insecure_sign_in_after_accept
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message if is_flashing_format?
        resource.after_database_authentication
        sign_in(resource_name, resource)
        respond_with resource, location: edit_profile_path
      else
        set_flash_message :notice, :updated_not_active if is_flashing_format?
        respond_with resource, location: new_session_path(resource_name)
      end
    else
      resource.invitation_token = raw_invitation_token
      respond_with(resource)
    end
  end

  private

  def create_couple
    # Assuming current_inviter is the other partner
    potential_couple = Couple.find_by(partner_1: current_inviter, partner_2: resource)
    potential_couple2 = Couple.find_by(partner_1: resource, partner_2: current_inviter)

    @existing_couple = potential_couple || potential_couple2
    if @existing_couple.nil?
      couple = Couple.new(partner_1: current_inviter, partner_2: resource)
      couple.save!
      create_first_memory(couple)
      Chatroom.create(couple:)
    end
  end

  def create_first_memory(couple)
    Event.create(date: current_user.created_at,
                 user: current_user,
                 couple:,
                 name: "Welcome!",
                 details: "The start of an amazing adventure!",
                 location: "Knoty app!",
                 is_memory: true)
  end
end
