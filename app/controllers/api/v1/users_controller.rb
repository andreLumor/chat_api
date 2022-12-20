class Api::V1::UsersController < ApplicationController
  # include JwtAuthable

  # before_action :auth!
  before_action :set_user, only: %i[ update ]

  # POST /api/v1/users
  # POST /api/v1/users.json
  def create
    Users::Creator.new.call(**user_params) do |on|
      on.success  { |user| render json: user, status: :created }
      on.failure { |errors| render json: { errors: errors.message }, status: :unprocessable_entity }
    end 
  end

  # PATCH/PUT /api/v1/users/1
  # PATCH/PUT /api/v1/users/1.json
  def update
    Users::Updater.new.call(**user_params, id: @user.id) do |on|
      on.success  { |message| render json: message, status: :ok }
      on.failure { |errors| render json: { errors: errors.message }, status: :unprocessable_entity }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end
