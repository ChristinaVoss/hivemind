# frozen_string_literal: true

class NavBarComponentPreview < ViewComponent::Preview
  def default
    render NavBarComponent.new(current_user: nil)
  end
end
