# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def update?
    user.admin? or record.id == user.id
  end

  def destroy?
    user.admin?
  end

  def create?
    user.admin?
  end

  def index?
    user.admin?
  end
end
