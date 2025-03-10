# frozen_string_literal: true

class CreateHiveComponent < ViewComponent::Base
  attr_reader :user

  def initialize(user:)
    @user = user

    super
  end
end
