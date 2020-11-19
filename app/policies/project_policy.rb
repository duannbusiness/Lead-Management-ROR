# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def update?
    user.has_role? :admin or  (user.has_role? :business_developer and record.lead.user_id == user.id)
  end

  def destroy?
    user.has_role? :admin or  (user.has_role? :business_developer and record.lead.user_id == user.id)
  end

  def create?
    user.has_role? :admin or  user.has_role? :business_developer
  end
end
