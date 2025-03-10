# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatsComponent, type: :component do
  subject { page }

  let(:component) { described_class.new(**args) }
  let(:args) { { description: 'Fun stats', value: '300 000' } }

  before { render_inline(component) }

  it { is_expected.to have_css '.stats' }
  it { is_expected.to have_text 'Fun stats' }
  it { is_expected.to have_text '300 000' }
end
