class Users::InvitationsController < Devise::InvitationsController

  # POST /resource/invitation
  def create
    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    if resource_invited
      # Create a Couple instance if the invite was successful
      create_couple

      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, email: self.resource.email
      end
      if self.method(:after_invite_path_for).arity == 1
        respond_with resource, location: after_invite_path_for(current_inviter)
      else
        respond_with resource, location: after_invite_path_for(current_inviter, resource)
      end
    else
      respond_with(resource)
    end
  end

  private

  def create_couple
    # Assuming current_inviter is the other partner
    potential_couple = Couple.find_by(partner1: current_inviter, partner2: resource)
    potential_couple2 = Couple.find_by(partner1: resource, partner2: current_inviter)

    @existing_couple = potential_couple || potential_couple2
    if @existing_couple.nil?
      couple = Couple.new(partner1: current_inviter, partner2: resource)
      couple.save!
    end
  end
end
