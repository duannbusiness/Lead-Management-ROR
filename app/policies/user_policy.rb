# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def update?
    user.has_role? :admin or record.id == user.id
  end

  def destroy?
    user.has_role? :admin
  end

  def create?
    user.has_role? :admin
  end

  def index?
    user.has_role? :admin
  end
end
