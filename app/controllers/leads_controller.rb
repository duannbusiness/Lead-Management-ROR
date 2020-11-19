# frozen_string_literal: true

# Lead controller for lead CRUD
class LeadsController < ApplicationController
  before_action :set_lead, only: %i[destroy show update edit]
  before_action :check_authorization, only: %i[destroy update edit]

  def index
    @lead = Lead.all
  end

  def new
    @lead = Lead.new
    authorize @lead
  end

  def create
    @lead = Lead.new(lead_params)
    authorize @lead
    @lead.user = current_user
    if @lead.save
      redirect_to @lead, notice: 'Lead add successfully'
    else
      flash[:error] = "ERROR: Lead not create successfully, #{@lead.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def edit; end

  def update
    if @lead.update(lead_params)
      redirect_to @lead, notice: 'Lead update successfully'
    else
      flash[:error] = "ERROR: Lead not update successfully, #{@lead.errors.full_messages.to_sentence}"
      render 'edit'
    end
  end

  def show; end

  def destroy
    if @lead.destroy
      flash[:notice] = 'Lead remove successfully'
    else
      flash[:error] = "ERROR: Lead not remove successfully, #{@lead.errors.full_messages.to_sentence}"
    end
    redirect_to leads_path
  end

  def status
    @lead = Lead.find(params[:lead_id])
    authorize @lead
    return unless request.post?

    if @lead.update(is_sale: params[:lead][:is_sale], transition_date: Time.zone.now)
      redirect_to @lead, notice: 'Lead status change successfully'
    else
      render 'status'
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:name, :client_name, :client_address, :client_email, :client_contact, :leadType)
  end

  def set_lead
    @lead = Lead.find(params[:id])
  end

  def check_authorization
    authorize @lead
  end
end
