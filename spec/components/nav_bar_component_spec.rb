# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NavBarComponent, type: :component do
  subject { page }

  let(:component) { described_class.new(**args) }
  let(:args) { { current_user: User.new } }

  before { render_inline(component) }

  it { is_expected.to have_css '.nav-bar' }
  it { is_expected.to have_css 'a', text: 'hive' }
  it { is_expected.to have_css 'form' }
  it { is_expected.to have_button 'Sign out' }
  it { is_expected.not_to have_css 'a', text: 'Sign in' }
  it { is_expected.not_to have_css 'a', text: 'Sign up' }

  context 'when user is not signed in' do
    let(:args) { { current_user: nil } }

    it { is_expected.to have_css 'a', text: 'Sign in' }
    it { is_expected.to have_css 'a', text: 'Sign up' }
    it { is_expected.not_to have_css 'form' }
    it { is_expected.not_to have_button 'Sign out' }
  end
end
