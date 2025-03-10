# frozen_string_literal: true

class BlankPageComponent < ViewComponent::Base
  BASE_CLASS = 'blank-page'
  attr_reader :component, :current_user, :attrs

  def initialize(component: nil, current_user: nil, attrs: {})
    classes = [BASE_CLASS]
    classes += Array(attrs[:class])

    @component = component
    @current_user = current_user
    @attrs = attrs.merge(class: classes)

    super
  end
end
