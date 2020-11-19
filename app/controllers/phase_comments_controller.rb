# frozen_string_literal: true

class PhaseCommentsController < ApplicationController
  before_action :set_phase

  def create
    @comment = @phase.comments.new(user_id: current_user.id, text: params[:text])
    if @comment.save
      flash[:notice] = 'Comment add successfully'
    else
      flash[:error] = "ERROR: Comment not add successfully  #{@comment.errors.full_messages.to_sentence}"
    end
    redirect_to lead_phase_path(@phase.lead_id, @phase.id)
  end

  def destroy
    @comment = @phase.comments.find(params[:id])
    authorize @comment
    if @comment.destroy
      flash[:notice] = 'remove comment from a phase successfully'
    else
      flash[:error] = "remove comment from a phase unsuccessfull #{@comment.errors.full_messages.to_sentence}"
    end
    redirect_to lead_phase_path(@phase.lead_id, @phase.id)
  end

  private

  def set_phase
    @phase = Phase.find(params[:phase_id])
  end
end
