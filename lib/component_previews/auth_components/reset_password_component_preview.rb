# frozen_string_literal: true

module AuthComponents
  class ResetPasswordComponentPreview < ViewComponent::Preview
    def default
      render(AuthComponents::ResetPasswordComponent.new(token: 'abc'))
    end
  end
end
