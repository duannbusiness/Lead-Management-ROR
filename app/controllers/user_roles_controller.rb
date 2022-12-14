# frozen_string_literal: true

# User_role controller for manage user roles CRUD
class UserRolesController < ApplicationController
  before_action :set_user, only: %i[index new create destroy]
  before_action :check_authorization

  def index
    @role = @user.roles
  end

  def new
    @roles = Role.all
  end

  def create
    role = Role.find(params[:role])
    if @user.add_role role.name
      redirect_to user_roles_path(params[:user_id]), notice: 'User role add successfully'
    else
      flash[:error] = "Assign role to a user is not successfully,  #{@user.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def destroy
    role = Role.find(params[:id])
    if @user.remove_role role.name
      flash[:notice] = 'Role remove successfully'
    else
      flash[:error] = "User role not remove successfully,  #{@user.errors.full_messages.to_sentence}"
    end
    redirect_to user_roles_path(params[:user_id])
  end

  private

  def phase_params
    params.require(:phase).permit(:lead_id, :name, :type, :description, :start_date, :due_date)
  end

  def phase_user_params
    params.require(:phase).permit(:phase_id, :user_id, :description)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def check_authorization
    authorize Role.new
  end
end
