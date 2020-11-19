# frozen_string_literal: true

class RequestPolicy < ApplicationPolicy
  def destroy?
    user.has_role? :admin or  (user.has_role? :business_developer and record.lead.user_id == user.id)
  end

  def create?
    user.has_role? :admin or  (user.has_role? :business_developer and
          record.lead.user_id == user.id and record.user_id.nil?)
  end
end
