# frozen_string_literal: true

class RequestPolicy < ApplicationPolicy
  def destroy?
    user.admin? || (user.developer? && record.phase.lead.user_id == user.id)
  end

  def create?
    user.admin? || user.developer?
  end
end
