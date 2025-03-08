# frozen_string_literal: true

class ForgotPasswordComponentPreview < ViewComponent::Preview
  def default
    render(ForgotPasswordComponent.new)
  end
end
