# frozen_string_literal: true

# Request controller for request CRUD
class RequestsController < ApplicationController
  before_action :set_phase, only: %i[index new create]

  def index
    @request = @phase.requests
  end

  def new
    @users = User.with_role :manager
    @request = @phase.requests.new
  end

  def create
    @request = @phase.requests.new(request_params)

    if @request.save
      RequestMailer.phase_add_manager_invitation(@request.user, @phase).deliver_now
      redirect_to phase_requests_path(@phase.id), notice: 'invitation send successfully'
    else
      @users = User.with_role :manager
      render 'new'
    end
  end

  def show
    @request = Request.find(params[:id])
  end

  def destroy
    @request = Request.find(params[:id])
    if @request.destroy
      flash[:notice] = 'Manager request remove successfully'
    else
      flash[:error] = 'Manager request  not remove successfully'
    end
    redirect_to phase_requests_path(params[:phase_id])
  end

  private

  def set_phase
    @phase = Phase.find(params[:phase_id])
  end

  def request_params
    params.require(:request).permit(:user_id, :description, :phase_id)
  end
end
