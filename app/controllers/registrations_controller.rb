# frozen_string_literal: true

class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  before_action :resume_session, only: %i[new create]

  def new
    component = AuthComponents::RegistrationComponent.new(user: User.new)
    render BlankPageComponent.new(component:, current_user:)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to new_hives_path,
                  notice: "You've successfully signed up to Hivemind. Welcome! Please choose your hive location."
    else
      component = AuthComponents::RegistrationComponent.new(user: @user)
      render BlankPageComponent.new(component:, current_user:), status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: %i[email_address password password_confirmation])
  end
end
