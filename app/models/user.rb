# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image
  has_many :leads, dependent: :destroy
  has_many :phase_users, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :phases, dependent: :destroy
  validates :first_name, :last_name, :user_name, presence: true
  validates :image, presence: true, blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }

  def admin?
    has_role? :admin
  end

  def engineer?
    has_role? :engineer
  end

  def developer?
    has_role? :business_developer
  end

  def manager?
    has_role? :manager
  end
end
