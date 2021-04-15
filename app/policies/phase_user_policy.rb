# frozen_string_literal: true

class PhaseUserPolicy < ApplicationPolicy
  def destroy?
    user.admin? ||  (user.manager? && record.user_id == user.id)
  end

  def create?
    user.admin? ||  (user.manager? && record.user_id == user.id)
  end
end
