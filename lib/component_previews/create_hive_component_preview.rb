# frozen_string_literal: true

class CreateHiveComponentPreview < ViewComponent::Preview
  def default
    render(CreateHiveComponent.new(user: "user"))
  end
end
