# frozen_string_literal: true

class BlankPageComponent < ViewComponent::Base
  BASE_CLASS = 'blank-page'
  attr_reader :component, :attrs

  def initialize(component: nil, attrs: {})
    classes = [BASE_CLASS]
    classes += Array(attrs[:class])

    @component = component
    @attrs = attrs.merge(class: classes)

    super
  end
end
