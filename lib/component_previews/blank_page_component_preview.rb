# frozen_string_literal: true

class BlankPageComponentPreview < ViewComponent::Preview
  def default
    component = RegistrationComponent.new(user: User.new)
    render(BlankPageComponent.new(component:))
  end
end
