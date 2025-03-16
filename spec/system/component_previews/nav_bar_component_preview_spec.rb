# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NavBarComponentPreview, type: :system do
  subject { page }

  let(:url) { preview_path }

  before { visit url }

  it_behaves_like 'an accessible component', within: '.nav-bar'
end
