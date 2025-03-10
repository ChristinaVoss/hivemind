# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomePageComponent, type: :component do
  subject { page }

  let(:component) { described_class.new(**args) }
  let(:args) { {} }

  before { render_inline(component) }

  it { is_expected.to have_css '.home-page h1', text: 'Welcome to Hivemind' }
end
