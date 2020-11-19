# frozen_string_literal: true

# User controller for CRUD
class UsersController < ApplicationController
  before_action :set_user, only: %i[destroy show update edit]
  before_action :check_authorization, only: %i[destroy update edit]

  def index
    @user = User.all
  end

  def new
    @user = User.new
    authorize @user
    @role = Role.all
  end

  def create
    @user = User.new(user_params)
    authorize @user
    if @user.save
      RequestMailer.user_registration(user_params).deliver_now
      redirect_to @user, notice: 'User add successfully with email notification'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'user update successfully'
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    if @user.destroy
      flash[:notice] = 'User remove successfully'
    else
      flash[:error] = 'User not remove successfully'
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user)
          .permit(
            :user_name,
            :email,
            :first_name,
            :password_confirmation,
            :password,
            :last_name,
            :contact_no,
            :address,
            :about,
            :image
          )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_authorization
    authorize @user
  end
end
