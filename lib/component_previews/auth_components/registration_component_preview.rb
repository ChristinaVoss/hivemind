# frozen_string_literal: true

module AuthComponents
  class RegistrationComponentPreview < ViewComponent::Preview
    def default
      render(AuthComponents::RegistrationComponent.new(user: User.new))
    end
  end
end
