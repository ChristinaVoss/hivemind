# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hive, type: :model do
  subject(:hive) { described_class.new(user: User.new, location: 'POINT(0.1228 52.2112)') }

  it { is_expected.to be_valid }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:location) }
  end

  describe '#distance' do
    let(:lat) { 52.2112 }
    let(:lng) { 0.1228 }

    context 'when the hive location is set' do
      it 'calculates the distance from the hive to the given coordinates' do
        expect(hive.distance(lat:, lng:)).to be_a(Float)
      end
    end

    context 'when the hive location is not set' do
      before { hive.location = nil }

      it 'raises an error' do
        expect { hive.distance(lat:, lng:) }.to raise_error('Hive location not set')
      end
    end

    context 'when the latitude is invalid' do
      let(:lat) { 100 }

      it 'raises an error' do
        expect { hive.distance(lat:, lng:) }.to raise_error(ArgumentError, 'Invalid latitude')
      end
    end

    context 'when the longitude is invalid' do
      let(:lng) { 200 }

      it 'raises an error' do
        expect { hive.distance(lat:, lng:) }.to raise_error(ArgumentError, 'Invalid longitude')
      end
    end
  end
end
