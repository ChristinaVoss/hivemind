# frozen_string_literal: true

class ResetPasswordComponent < ViewComponent::Base
  BASE_CLASS = 'reset-password'
  attr_reader :token, :attrs

  def initialize(token: nil, attrs: {})
    classes = [BASE_CLASS]
    classes += Array(attrs[:class])

    @token = token
    @attrs = attrs.merge(class: classes)

    super
  end
end
