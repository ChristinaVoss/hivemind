# frozen_string_literal: true

class MapComponent < ViewComponent::Base
  def initialize(location:)
    @location = location
  end
end
