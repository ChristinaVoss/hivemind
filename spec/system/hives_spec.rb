require 'rails_helper'

RSpec.describe 'Hives', type: :system do
  let(:user) { User.create!(email_address: 'test@example.com', password: 'password') }
  let!(:hive) { Hive.create!(user:, location: 'POINT(-0.1257 51.5085)') }

  before do
    driven_by(:selenium_chrome_headless)
    sign_in user
  end

  it 'calculates the distance from the hive', :js do
    visit dashboard_path

    expect(page).to have_content('Plan your day')

    # Simulate clicking on the map to calculate distance
    page.execute_script("document.querySelector('[data-controller=\"map\"]').dispatchEvent(new MouseEvent('click', { clientX: 100, clientY: 100 }))")

    # Wait for the distance calculation to complete
    expect(page).to have_content('Distance from hive')
    expect(page).to have_content('Bee flight time to hive')
  end
end
