# frozen_string_literal: true

class StatsComponentPreview < ViewComponent::Preview
  def default
    render(StatsComponent.new(description: 'description', value: 'value', stats_id: 'stats_id'))
  end
end
