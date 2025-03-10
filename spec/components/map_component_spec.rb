# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapComponent, type: :component do
  subject { page }
  user = User.new(email_address: 'queen@hive.com', password: 'nectar123')
  hive = Hive.new(user:, location: 'POINT(0.1228 52.2112)')

  let(:component) { described_class.new(**args) }
  let(:hive) { Hive.new(user: User.new, location: 'POINT(0.1228 52.2112)') }
  let(:args) { { location: hive.location } }

  before { render_inline(component) }

  it { is_expected.to have_css '.map' }
  it { is_expected.to have_css 'div#map[data-map-hive-lat-value="52.2112"]' }
  it { is_expected.to have_css 'div#map[data-map-hive-lng-value="0.1228"]' }
end
