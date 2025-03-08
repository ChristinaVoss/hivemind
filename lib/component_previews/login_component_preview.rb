# frozen_string_literal: true

class LoginComponentPreview < ViewComponent::Preview
  def default
    render(LoginComponent.new)
  end
end
