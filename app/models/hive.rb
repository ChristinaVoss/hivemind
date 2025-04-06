# frozen_string_literal: true

class Hive < ApplicationRecord
  belongs_to :user
  validates :location, presence: true

  def distance(lat:, lng:) # rubocop:disable Metrics/AbcSize
    # Check that lat lng are valid
    raise ArgumentError, 'Invalid latitude' unless lat.is_a?(Numeric) && lat.between?(-90, 90)
    raise ArgumentError, 'Invalid longitude' unless lng.is_a?(Numeric) && lng.between?(-180, 180)
    # Check that the hive location is set
    raise 'Hive location not set' if location.nil?

    factory = RGeo::Geographic.spherical_factory(srid: 4326)
    bee_location = factory.point(lng, lat)

    # Safely quote the hive location and bee location
    quoted_hive_location = Hive.connection.quote(location.as_text)
    quoted_bee_location = Hive.connection.quote(bee_location)

    # Calculate the distance from the current user's hive to the given coordinates
    Hive.connection.exec_query(
      "SELECT ST_Distance(
        #{quoted_hive_location}::geography,
        #{quoted_bee_location}::geography
      ) / 1000 AS distance"
    ).first['distance']
  end
end
