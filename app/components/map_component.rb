# frozen_string_literal: true

class MapComponent < ViewComponent::Base
  attr_reader :location

  def initialize(location:)
    @location = location

    super
  end
end
