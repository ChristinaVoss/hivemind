# frozen_string_literal: true

class HivesController < ApplicationController
  load_and_authorize_resource except: :home
  allow_unauthenticated_access only: %i[home]
  before_action :resume_session, only: :home

  def show
    hive = current_user.hive
    return redirect_to new_hive_path, alert: 'Please create a hive first.' if hive.nil?

    component = DashboardComponent.new(hive:)
    render BlankPageComponent.new(component:, current_user:)
  end

  def home
    component = HomePageComponent.new
    render BlankPageComponent.new(component:, current_user:)
  end

  def new
    component = CreateHiveComponent.new(user: current_user)
    render BlankPageComponent.new(component:, current_user:)
  end

  def create # rubocop:disable Metrics/AbcSize
    factory = RGeo::Geographic.spherical_factory(srid: 4326)
    hive_location = factory.point(hive_params[:location][0], hive_params[:location][1])
    hive = current_user.hive || current_user.build_hive
    hive.location = hive_location

    return redirect_to dashboard_path, notice: 'Hive location saved successfully!' if hive.save

    flash.now[:alert] = hive.errors.full_messages.join(', ')
    component = CreateHiveComponent.new(user: current_user)
    render BlankPageComponent.new(component:, current_user:), status: :unprocessable_entity
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

  private

  def hive_params
    params.expect(hive: [location: []])
  end
end
