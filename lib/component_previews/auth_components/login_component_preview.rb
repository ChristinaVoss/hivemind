# frozen_string_literal: true

module AuthComponents
  class LoginComponentPreview < ViewComponent::Preview
    def default
      render(AuthComponents::LoginComponent.new)
    end
  end
end
