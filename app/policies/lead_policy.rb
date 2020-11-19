# frozen_string_literal: true

class LeadPolicy < ApplicationPolicy
  def update?
    user.admin? or  (user.developer? and record.user_id == user.id)
  end

  def destroy?
    user.admin? or  (user.developer? and record.user_id == user.id)
  end

  def create?
    user.admin? or  user.developer?
  end

  def status?
    (user.admin? or user.developer?) and record.is_sale != 'sale'
  end
end
