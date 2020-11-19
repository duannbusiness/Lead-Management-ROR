# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def destroy?
    user.admin? or record.user_id == user.id
  end
end
