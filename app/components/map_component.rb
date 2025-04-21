# frozen_string_literal: true

class MapComponent < ViewComponent::Base
  attr_reader :location, :attrs, :controller

  def initialize(location: nil, attrs: {}, controller: nil)
    @location = location
    @attrs = attrs
    @controller = controller

    super
  end

  def data_attributes
    attrs.transform_keys { |key| "data-#{key.to_s.dasherize}" }
         .merge(controller ? { 'data-controller': controller } : {})
  end
end
