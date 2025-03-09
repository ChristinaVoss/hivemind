class HivesController < ApplicationController
  load_and_authorize_resource

  def show
    hive = current_user.hive
    map = MapComponent.new(location: hive.location)
    render BlankPageComponent.new(component: map)
  end

  def distance
    hive = current_user.hive
    lat = params[:lat].to_f
    lng = params[:lng].to_f

  # Calculate the distance from the current user's hive to the given coordinates
  distance = ActiveRecord::Base.connection.execute(
    "SELECT ST_Distance(
      '#{hive.location}'::geography,
      ST_SetSRID(ST_MakePoint(#{lng}, #{lat}), 4326)::geography
    ) / 1000 AS distance"
  ).first["distance"]

    bee_flight_time = (distance / User::BEE_SPEED_TO_HIVE)  * 60 * 60 # Convert hours to seconds

    render json: { distance: distance.round(2), bee_flight_time: bee_flight_time.round }
  end
end
