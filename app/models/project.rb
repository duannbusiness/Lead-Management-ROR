# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :lead
  belongs_to :user

  validates :name, :lead_id, :user_id, presence: true
end
