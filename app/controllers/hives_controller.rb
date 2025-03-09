# frozen_string_literal: true

class HivesController < ApplicationController
  load_and_authorize_resource

  def show
    hive = current_user.hive
    # map = MapComponent.new(location: hive.location)
    component = DashboardComponent.new(hive:)
    render BlankPageComponent.new(component:)
  end

  def distance # rubocop:disable Metrics/AbcSize
    hive = current_user.hive
    lat = params[:lat].to_f
    lng = params[:lng].to_f

    factory = RGeo::Geographic.spherical_factory(srid: 4326)
    hive_location = factory.point(hive.location.x, hive.location.y)
    bee_location = factory.point(lng, lat)

    # Safely quote the hive location and click location
    quoted_hive_location = Hive.connection.quote(hive_location)
    quoted_bee_location = Hive.connection.quote(bee_location)

    # Calculate the distance from the current user's hive to the given coordinates
    distance = Hive.connection.exec_query(
      "SELECT ST_Distance(
        #{quoted_hive_location}::geography,
        #{quoted_bee_location}::geography
      ) / 1000 AS distance"
    ).first['distance']

    bee_flight_time = (distance / User::BEE_SPEED_TO_HIVE) * 60 * 60 # Convert hours to seconds

    render json: { distance: distance.round(2), bee_flight_time: bee_flight_time.round }
  end
end
