# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthComponents::ResetPasswordComponent, type: :component do
  subject { page }

  let(:component) { described_class.new(**args) }
  let(:args) { { token: 'abc' } }

  before { render_inline(component) }

  it { is_expected.to have_css '.reset-password form' }
  it { is_expected.to have_css '.form__field label', text: 'Password' }
  it { is_expected.to have_css 'input#password' }
  it { is_expected.to have_css '.form__field label', text: 'Password confirmation' }
  it { is_expected.to have_css 'input#password_confirmation' }
end
