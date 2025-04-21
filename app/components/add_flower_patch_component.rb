# frozen_string_literal: true

class AddFlowerPatchComponent < ViewComponent::Base
  attr_reader :hive, :user

  def initialize(hive:, user:)
    @hive = hive
    @user = user

    super
  end
end
