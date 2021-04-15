# frozen_string_literal: true

# Phase controller for phase CRUD
class PhasesController < ApplicationController
  before_action :authenticate_user!, except: %i[accept reject status]
  before_action :set_lead, except: %i[accept reject status]
  before_action :set_phase, except: %i[index new create accept reject status]
  before_action :check_authorization, only: %i[new create]
  layout 'login', only: %i[reject]

  def index
    @phases = @lead.phases
  end

  def new
    @phase = Phase.new
  end

  def create
    @phase = @lead.phases.new(phase_params)
    authorize @phase
    if @phase.save
      redirect_to lead_phase_path(params[:lead_id], @phase.id), notice: 'Phase add successfully'
    else
      flash[:error] = "Phase not Create successfully  #{@phase.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def edit
    authorize @phase
  end

  def update
    authorize @phase
    if @phase.update(phase_params)
      redirect_to lead_phases_path(params[:lead_id]), notice: 'Phase update successfully'
    else
      flash[:error] = "Phase not update successfully  #{@phase.errors.full_messages.to_sentence}"
      render 'edit'
    end
  end

  def show; end

  def destroy
    authorize @phase
    if @phase.destroy
      flash[:notice] = 'Phase remove successfully'
    else
      flash[:error] = "Phase not remove successfully #{@phase.errors.full_messages.to_sentence}"
    end
    redirect_to lead_phases_path(params[:lead_id])
  end

  def accept
    return unless User.exists?(id: params[:id])

    @phase = Phase.find_by(id: params[:phase_id])
    authorize @phase
    ActiveRecord::Base.transaction do
      @phase.update!(user_id: params[:id])
      @request = @phase.requests.find_by(user_id: params[:id])
      @request.update!(status: 'accept')
    end
    redirect_to new_user_session_path, notice: 'You are successfully added in to a lead. Please login for Confirmation'
  end

  def status
    @phase = Phase.find(params[:phase_id])
    authorize @phase
    return unless request.post?

    if @phase.update(phase_status_params)
      redirect_to lead_phases_path(@phase.lead_id), notice: 'Phase status change successfully'
    else
      flash[:error] = "Phase status not change successfully #{@phase.errors.full_messages.to_sentence}"
      render 'status'
    end
  end

  def reject
    @phase = Phase.find_by(id: params[:phase_id])
    authorize @phase
    @user = User.find_by(id: params[:id])
    return unless request.post?

    return unless User.exists?(id: params[:id])

    ActiveRecord::Base.transaction do
      @lead = @phase.lead
      @comment = @phase.comments.create(user_id: params[:id], text: params[:text])
      @request = @phase.requests.find_by(user_id: params[:id])
      @request.update!(status: 'reject')
    end
    redirect_to new_user_session_path, notice: 'Thanks'
  end

  private

  def phase_params
    params.require(:phase).permit(:name, :phaseType, :description, :start_date, :due_date)
  end

  def phase_status_params
    params.require(:phase).permit(:status)
  end

  def set_lead
    @lead = Lead.find(params[:lead_id])
  end

  def set_phase
    @phase = Phase.find(params[:id])
  end

  def check_authorization
    authorize @lead
  end
end
