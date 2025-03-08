# frozen_string_literal: true

class RegistrationComponent < ViewComponent::Base
  BASE_CLASS = "registration"
  attr_reader :user, :attrs

  def initialize(user: nil, attrs: {})
    classes = [ BASE_CLASS ]
    classes += Array(attrs[:class])

    @user = user
    @attrs = attrs.merge(class: classes)

    super
  end
end
