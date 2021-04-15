# frozen_string_literal: true

class PhasePolicy < ApplicationPolicy
  def update?
    user.admin? || (user.developer? &&
        record.lead.user_id == user.id)
  end

  def destroy?
    user.admin? || (user.developer? && record.lead.user_id == user.id)
  end

  def create?
    user.admin? ||  user.developer?
  end

  def status?
    user.admin? || (user.manager? && record.user_id == user.id) || (user.developer? && record.lead.user_id == user.id)
  end

  def accept?
    user.manager? && record.requests.exists?(user_id: user.id)
  end

  def reject?
    user.manager? && record.requests.exists?(user_id: user.id)
  end
end
