# frozen_string_literal: true

class MapComponentPreview < ViewComponent::Preview
  def default
    hive = Hive.new(location: 'POINT(0.1228 52.2112)')
    render(MapComponent.new(location: hive.location))
  end
end
