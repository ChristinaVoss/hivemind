# frozen_string_literal: true

class MapComponent < ViewComponent::Base
  attr_reader :location, :attrs

  def initialize(location:, attrs: {})
    @location = location
    @attrs = attrs

    super
  end

  def data_attributes
    attrs.transform_keys { |key| "data-#{key.to_s.dasherize}" }
  end
end
