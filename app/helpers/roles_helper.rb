# frozen_string_literal: true

module RolesHelper
  def role_delete_button(role)
    return unless policy(role).destroy?

    link_to 'Remove Role', role_path(role), method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-danger'
  end

  def role_create_button(role)
    link_to 'Create New Role', new_role_path, class: 'btn btn-info' if policy(role).create?
  end
end
