# frozen_string_literal: true

class PhaseUserPolicy < ApplicationPolicy
  def destroy?
    user.has_role? :admin or  (user.has_role? :manager and record.user_id == user.id)
  end

  def create?
    user.has_role? :admin or  (user.has_role? :manager and record.user_id == user.id)
  end
end
