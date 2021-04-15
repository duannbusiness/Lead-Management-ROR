# frozen_string_literal: true

# Request controller for request CRUD
class RequestsController < ApplicationController
  before_action :set_phase, only: %i[index new create]

  def index
    @request = @phase.requests
  end

  def new
    @request = @phase.requests.new
    authorize @request
  end

  def create
    @request = @phase.requests.new(request_params)
    authorize @request
    if @request.save
      redirect_to phase_requests_path(@phase.id), notice: 'invitation send successfully'
    else
      flash[:error] = "Manager request  not create successfully,  #{@request.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def show
    @request = Request.find(params[:id])
  end

  def destroy
    @request = Request.find_by(id: params[:id])
    authorize @request
    if @request.destroy
      flash[:notice] = 'Manager request remove successfully'
    else
      flash[:error] = "Manager request  not remove successfully,  #{@request.errors.full_messages.to_sentence}"
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
