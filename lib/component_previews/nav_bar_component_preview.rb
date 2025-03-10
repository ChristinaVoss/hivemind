# frozen_string_literal: true

class NavBarComponentPreview < ViewComponent::Preview
  # @param current_user_present toggle
  def default(current_user_present: true)
    current_user = current_user_present ? User.new(email_address: 'buzzy@email.com', password: 'nectar123') : nil
    render NavBarComponent.new(current_user:)
  end
end
