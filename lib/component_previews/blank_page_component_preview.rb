# frozen_string_literal: true

class BlankPageComponentPreview < ViewComponent::Preview
  def default
    render(BlankPageComponent.new)
  end
end
