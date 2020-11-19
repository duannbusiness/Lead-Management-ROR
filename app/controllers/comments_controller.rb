# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_lead

  def create
    @comment = @lead.comments.new(user_id: current_user.id, text: params[:text])
    if @comment.save
      flash[:notice] = 'Comment add successfully'
    else
      flash[:error] = "ERROR: Comment not add successfully  #{@comment.errors.full_messages.to_sentence}"
    end
    redirect_to lead_path(@lead)
  end

  def destroy
    @comment = @lead.comments.find_by(id: params[:id])
    authorize @comment
    if @comment.destroy
      flash[:notice] = 'Comment remove successfully'
    else
      flash[:error] = "ERROR: Comment not remove successfully #{@comment.errors.full_messages.to_sentence}"
    end
    redirect_to lead_path(@lead)
  end

  private

  def set_lead
    @lead = Lead.find(params[:lead_id])
  end
end
