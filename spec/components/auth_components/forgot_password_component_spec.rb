# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthComponents::ForgotPasswordComponent, type: :component do
  subject { page }

  let(:component) { described_class.new(**args) }
  let(:args) { {} }

  before { render_inline(component) }

  it { is_expected.to have_css '.forgot-password form' }
  it { is_expected.to have_css '.form__field label', text: 'Email address' }
  it { is_expected.to have_css 'input#email_address' }
end
