# frozen_string_literal: true

module UsersHelper
  def user_edit_button(user)
    link_to 'Edit', edit_user_path(user.id), class: 'btn btn-primary' if policy(user).edit?
  end

  def user_delete_button(user)
    return unless policy(user).destroy?

    link_to 'Destroy', user_path(user), method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-danger'
  end

  def user_create_button
    link_to 'Add User', new_user_path, class: 'btn btn-info' if policy(User.new).new?
  end

  def user_back_button
    link_to 'Back', users_path, class: 'btn btn-info'
  end

  def user_role_button(user)
    link_to 'Role', user_roles_path(user.id), class: 'btn btn-info' if policy(user).index?
  end

  def manager_dropdown_option
    users = User.with_role :manager
    users.map { |u| [u.user_name, u.id] }
  end

  def engineer_dropdown_option
    users = User.with_role :engineer
    users.map { |u| [u.user_name, u.id] }
  end
end
