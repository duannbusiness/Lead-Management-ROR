# frozen_string_literal: true

class PhasePolicy < ApplicationPolicy
  def update?
    user.admin? or (user.developer? and
        record.lead.user_id == user.id)
  end

  def destroy?
    user.admin? or  (user.developer? and record.lead.user_id == user.id)
  end

  def create?
    user.admin? or  user.developer?
  end

  def status?
    user.admin? or (user.manager? and record.user_id == user.id)
  end
end
