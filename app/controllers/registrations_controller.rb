# frozen_string_literal: true

class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  before_action :resume_session, only: %i[new create]

  def new
    component = RegistrationComponent.new(user: User.new)
    render BlankPageComponent.new(component:)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      # redirect_to root_path, notice: "You've successfully signed up to Joblister. Welcome!"
      redirect_to '/', notice: "You've successfully signed up to Joblister. Welcome!"
    else
      flash[:alert] = @user.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: %i[email_address password password_confirmation])
  end
end
