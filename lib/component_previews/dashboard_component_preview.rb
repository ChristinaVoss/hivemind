# frozen_string_literal: true

class DashboardComponentPreview < ViewComponent::Preview
  def default
    user = User.new(email_address: 'queen@hive.com', password: 'nectar123')
    hive = Hive.new(user:, location: 'POINT(0.1228 52.2112)')

    render(DashboardComponent.new(hive:))
  end
end
