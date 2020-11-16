# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_lead

  def create
    @comment = @lead.comments.new(user_id: current_user.id, text: params[:text])
    @comment.save!
    redirect_to lead_path(@lead), notice: 'Comment add successfully'
  end

  def destroy
    @comment = @lead.comments.find(params[:id])
    @comment.destroy!
    redirect_to lead_path(@lead), notice: 'Comment delete successfully'
  end

  private

  def set_lead
    @lead = Lead.find(params[:lead_id])
  end
end
