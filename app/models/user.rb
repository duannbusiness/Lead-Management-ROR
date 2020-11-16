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

  validates :first_name, :last_name, :user_name, presence: true
  def admin?
    user.has_role? :admin
  end

  def developer?
    user.has_role? :business_developer
  end

  def manager?
    user.has_role? :manager
  end

  def engineer?
    user.has_role? :engineer
  end
end
