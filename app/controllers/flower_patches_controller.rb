# frozen_string_literal: true

#
class FlowerPatchesController < ApplicationController
  # before_action :set_flower_patch, only: %i[show edit update destroy]
  # before_action :set_user, only: %i[new create]
  # before_action :set_hive, only: %i[new create]
  load_and_authorize_resource

  # def index
  #   @flower_patches = FlowerPatch.all
  # end

  # def show; end

  def new
    @flower_patch = FlowerPatch.new
    component = AddFlowerPatchComponent.new(user: current_user, hive: current_user.hive)
    render BlankPageComponent.new(component:, current_user:)
  end

  # def edit; end

  def create
    # Convert ActionController::Parameters to a plain Ruby hash
    geojson = params[:flower_patch][:area].to_unsafe_h

    # Decode the GeoJSON into an RGeo object
    polygon = RGeo::GeoJSON.decode(geojson, json_parser: :json)

    # Create the flower patch
    flower_patch = current_user.flower_patches.new(area: polygon)

    if flower_patch.save
      render json: { status: 'ok' }, status: :created
    else
      render json: { errors: flower_patch.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def flower_patch_params
    params.require(:flower_patch).permit(:area, :location, :hive_id)
  end
end
