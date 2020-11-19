# frozen_string_literal: true

class PhaseUserPolicy < ApplicationPolicy
  def destroy?
    user.admin? or  (user.manager? and record.user_id == user.id)
  end

  def create?
    user.admin? or  (user.manager? and record.user_id == user.id)
  end
end
