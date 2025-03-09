# frozen_string_literal: true

class ResetPasswordComponentPreview < ViewComponent::Preview
  def default
    render(ResetPasswordComponent.new(token: 'abc'))
  end
end
