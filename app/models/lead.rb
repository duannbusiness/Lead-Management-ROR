# frozen_string_literal: true

class Lead < ApplicationRecord
  belongs_to :user
  has_many :phases, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  
  validates :name, :client_name, :client_address, :client_email, :client_contact, :leadType, presence: true
end
