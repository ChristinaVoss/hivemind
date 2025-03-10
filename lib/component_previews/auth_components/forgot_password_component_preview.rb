# frozen_string_literal: true

module AuthComponents
  class ForgotPasswordComponentPreview < ViewComponent::Preview
    def default
      render(AuthComponents::ForgotPasswordComponent.new)
    end
  end
end
