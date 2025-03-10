# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlankPageComponent, type: :component do
  subject { page }

  let(:blank_page_component) { described_class.new(**args) }
  let(:component) { HomePageComponent.new }
  let(:args) { { component: } }

  before { render_inline(blank_page_component) }

  it { is_expected.to have_css '.blank-page' }
end
