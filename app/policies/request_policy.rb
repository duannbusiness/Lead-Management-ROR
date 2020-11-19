# frozen_string_literal: true

class RequestPolicy < ApplicationPolicy
  def destroy?
    user.admin? or  (user.developer? and record.lead.user_id == user.id)
  end

  def create?
    user.admin? or  (user.developer? and
          record.lead.user_id == user.id and record.user_id.nil?)
  end
end
