# frozen_string_literal: true

class PhasePolicy < ApplicationPolicy
  def update?
    user.has_role? :admin or (user.has_role? :business_developer and record.lead.user_id == user.id) or (user.has_role? :manager and record.user_id == user.id)
  end

  def destroy?
    user.has_role? :admin or  (user.has_role? :business_developer and record.user_id == user.id)
  end

  def create?
    user.has_role? :admin or  user.has_role? :business_developer
  end

  def phase_user_create?
    PhaseUserPolicy.new(user, record).create?
  end

  def phase_user_destroy?
    PhaseUserPolicy.new(user, record).destroy?
  end

  def phase_manager_create?
    RequestPolicy.new(user, record).create?
  end

  def phase_manager_destroy?
    RequestPolicy.new(user, record).destroy?
  end

  def status?
    user.has_role? :admin or (user.has_role? :manager and record.user_id == user.id)
  end
end
