# frozen_string_literal: true

class NavBarComponentPreview < ViewComponent::Preview
  def default
    render NavBarComponent.new
  end
end
