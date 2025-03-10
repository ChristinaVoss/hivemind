# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegistrationComponent, type: :component do
  subject { page }

  let(:component) { described_class.new(**args) }
  let(:args) { { user: User.new } }

  before { render_inline(component) }

  it { is_expected.to have_css '.registration form' }
  it { is_expected.to have_css '.form__field label', text: 'Email address' }
  it { is_expected.to have_css 'input#user_email_address' }
  it { is_expected.to have_css '.form__field label', text: 'Password' }
  it { is_expected.to have_css 'input#user_password' }
  it { is_expected.to have_css '.form__field label', text: 'Password confirmation' }
  it { is_expected.to have_css 'input#user_password_confirmation' }
end
