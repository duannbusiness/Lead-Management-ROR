# frozen_string_literal: true

class LeadPolicy < ApplicationPolicy
  def update?
    user.admin? ||  (user.developer? && record.user_id == user.id)
  end

  def destroy?
    user.admin? ||  (user.developer? && record.user_id == user.id)
  end

  def create?
    user.admin? ||  user.developer?
  end

  def status?
    (user.admin? || user.developer?) && record.is_sale != 'sale'
  end
end
