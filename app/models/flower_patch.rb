# frozen_string_literal: true

class FlowerPatch < ApplicationRecord
  belongs_to :user

  validates :area, presence: true
  validates :area, length: { maximum: 10_000, message: 'is too large' }
  validate :validate_geojson

  private

  def validate_geojson
    return if area.is_a?(RGeo::Feature::Geometry) && area.geometry_type == RGeo::Feature::Polygon

    errors.add(:area, 'must be a valid GeoJSON Polygon')
  end
end
