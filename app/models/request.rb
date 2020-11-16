# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :phase
  belongs_to :user
  validates :user_id, :description, presence: true
end
