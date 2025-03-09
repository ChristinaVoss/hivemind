# frozen_string_literal: true

class DashboardComponentPreview < ViewComponent::Preview
  def default
    render(DashboardComponent.new(hive: 'hive'))
  end
end
