# frozen_string_literal: true

class RolePolicy < ApplicationPolicy
  def update?
    user.has_role? :admin
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
