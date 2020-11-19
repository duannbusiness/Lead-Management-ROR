# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def update?
    user.admin? or  (user.developer? and record.lead.user_id == user.id)
  end

  def destroy?
    user.admin? or  (user.developer? and record.lead.user_id == user.id)
  end

  def create?
    user.admin? or  user.developer?
  end
end
