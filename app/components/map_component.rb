# frozen_string_literal: true

class MapComponent < ViewComponent::Base
  attr_reader :location, :attrs

  def initialize(location:, attrs: {})
    @location = location
    @attrs = attrs

    super
  end
end
