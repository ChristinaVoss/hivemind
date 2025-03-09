class HivesController < ApplicationController
  load_and_authorize_resource

  def show
    # `@hive` is already loaded and authorized by Cancancan
  end
end
