# frozen_string_literal: true

class AddFlowerPatchComponentPreview < ViewComponent::Preview
  def default
    render(AddFlowerPatchComponent.new(user: User.first, hive: Hive.first))
  end
end
