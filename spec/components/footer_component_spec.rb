# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FooterComponent, type: :component do
  subject { page }

  let(:component) { described_class.new(**args) }
  let(:args) { {} }

  before { render_inline(component) }

  it { is_expected.to have_css '.footer', text: '© 2021 Hivemind. All rights reserved. Or none. Who knows? 🤷‍♂️' }
end
