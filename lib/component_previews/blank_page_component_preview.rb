# frozen_string_literal: true

class BlankPageComponentPreview < ViewComponent::Preview
  def default
    component = AuthComponents::RegistrationComponent.new(user: User.new)
    render(BlankPageComponent.new(component:, current_user: nil))
  end
end
