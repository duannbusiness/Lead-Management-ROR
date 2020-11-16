# frozen_string_literal: true

class PhaseCommentsController < ApplicationController
  before_action :set_phase

  def create
    @comment = @phase.comments.new(user_id: current_user.id, text: params[:text])
    @comment.save!
    redirect_to lead_phase_path(@phase.lead_id, @phase.id), notice: 'Comment add on a phase successfully'
  end

  def destroy
    @comment = @phase.comments.find(params[:id])
    @comment.destroy!
    redirect_to lead_phase_path(@phase.lead_id, @phase.id), notice: 'Remove comment from a phase successfully'
  end

  private

  def set_phase
    @phase = Phase.find(params[:phase_id])
  end
end
