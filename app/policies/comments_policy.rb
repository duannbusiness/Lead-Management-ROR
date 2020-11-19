# frozen_string_literal: true

class CommentsPolicy < ApplicationPolicy
  def destroy?
    user.admin? or record.user_id == user.id
  end
end
