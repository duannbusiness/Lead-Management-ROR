# frozen_string_literal: true

class CommentsPolicy < ApplicationPolicy
  def destroy?
    user.has_role? :admin or record.user_id == user.id
  end
end
