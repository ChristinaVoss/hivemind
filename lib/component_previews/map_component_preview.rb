# frozen_string_literal: true

class MapComponentPreview < ViewComponent::Preview
  def default
    render(MapComponent.new(location: 'POINT(-0.1278 51.5074)'))
  end
end
