# frozen_string_literal: true

class RegistrationComponentPreview < ViewComponent::Preview
  def default
    render(RegistrationComponent.new(user: User.new))
  end
end
