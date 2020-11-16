# frozen_string_literal: true

# Request controller for request CRUD
class RequestsController < ApplicationController
  before_action :set_phase, only: %i[index new create]

  def index
    @request = @phase.requests
  end

  def new
    @user = User.with_role :manager
    @request = @phase.requests.new
  end

  def create
    @request = @phase.requests.new(request_params)

    if @request.save
      RequestMailer.registration_confirmation(@request.user, @phase).deliver
      redirect_to phase_requests_path(@phase.id), notice: 'invitation send successfully'
    else
      @user = User.with_role :manager
      render 'new'
    end
  end

  def show
    @request = Request.find(params[:id])
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy!
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
