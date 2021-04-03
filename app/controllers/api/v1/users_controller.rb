class Api::V1::UsersController < ApplicationController

  USER_PARAMS = [:first_name, :last_name, :email, :encrypted_password]

  def index
    users = User.all
    render json: users, status: 200
  end

  def show
    user = User.find_by_id(params[:id])
    if user
      render json: user, status: 200
    else
      render json: {error: "user not found"}, status: 404
    end
  end

  def create
    user = User.build(params.slice(*USER_PARAMS))
    if user.save
      render json: user, status: 201
    else
      render json: {error: "error creating user"}, status: 400
    end
  end
  
  def update
    user = User.find_by_id(params[:id])
    render json: { error: "user not found" }, status: 404 unless user
    if user.update_attributes(params.slice(*USER_PARAMS))
      render json: user, status: 200
    else
      render json: {error: "user could not be updated"}, , status: 400
    end
  end
end
