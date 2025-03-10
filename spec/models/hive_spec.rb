# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hive, type: :model do
  subject(:hive) { described_class.new(user: User.new, location: 'POINT(0.1228 52.2112)') }

  it { is_expected.to be_valid }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:location) }
  end
end
