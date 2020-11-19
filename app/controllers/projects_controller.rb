# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[destroy show update edit]
  before_action :check_authorization, only: %i[destroy update edit]

  def index
    @project = Project.all
  end

  def edit
    @users = User.with_role :manager
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'project update successfully'
    else
      @users = User.with_role :manager
      render 'edit'
    end
  end

  def show; end

  def destroy
    if @project.destroy
      flash[:notice] = 'project remove successfully'
    else
      flash[:error] = 'ERROR: project not remove successfully'
    end
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :user_id)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def check_authorization
    authorize @project
  end
end
