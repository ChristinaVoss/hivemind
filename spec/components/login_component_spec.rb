# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginComponent, type: :component do
  subject { page }

  let(:component) { described_class.new(**args) }
  let(:args) { {} }

  before { render_inline(component) }

  it { is_expected.to have_css '.login form' }
  it { is_expected.to have_css '.form__field label', text: 'Email address' }
  it { is_expected.to have_css 'input#email_address' }
  it { is_expected.to have_css '.form__field label', text: 'Password' }
  it { is_expected.to have_css 'input#password' }
end
