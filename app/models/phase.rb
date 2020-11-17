# frozen_string_literal: true

class Phase < ApplicationRecord
  belongs_to :lead
  has_many :phase_users, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :lead_id, :name, :phaseType, :description, :start_date, :due_date, presence: true

  enum status: { pending: false, completed: true }
end
