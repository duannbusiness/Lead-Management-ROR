# frozen_string_literal: true

# Roles controller for assign/view roles
class RolesController < ApplicationController
  before_action :check_authorization

  def index
    @role = Role.all
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to roles_path
    else
      render 'new'
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy!
    redirect_to roles_path
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

  def check_authorization
    authorize Role.new
  end
end
