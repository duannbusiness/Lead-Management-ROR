# frozen_string_literal: true

class Lead < ApplicationRecord
  belongs_to :user
  has_many :phases, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_one :project, dependent: :destroy
  validates :name, :client_name, :client_address, :client_email, :client_contact, :leadType, presence: true
  enum is_sale: { not_sale: 0, sale: 1 }
  after_update :check_status

  private

  def check_status
    return unless is_sale == 'sale'

    result = User.with_role :manager
    if result.empty?
      [nil, { error: 'Sorry, Mangaer not found' }]
    else
      Project.create(name: name, lead_id: id, user_id: result.first.id)
    end
  end
end
