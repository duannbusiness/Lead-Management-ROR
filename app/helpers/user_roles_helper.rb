# frozen_string_literal: true

module UserRolesHelper
  def user_role_delete_button(user, role)
    return unless policy(role).destroy?

    link_to 'Destroy', user_role_path(user.id, role.id),
            method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-danger'
  end

  def user_role_create_button(role)
    link_to 'Assign new Role', new_user_role_path, class: 'btn btn-info' if policy(role).create?
  end
end
