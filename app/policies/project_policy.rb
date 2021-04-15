# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def update?
    user.admin? ||  (user.developer? && record.lead.user_id == user.id)
  end

  def destroy?
    user.admin? ||  (user.developer? && record.lead.user_id == user.id)
  end

  def create?
    user.admin? ||  user.developer?
  end
end
