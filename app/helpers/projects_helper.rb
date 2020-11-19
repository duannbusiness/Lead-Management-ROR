# frozen_string_literal: true

module ProjectsHelper
  def project_edit_button(project)
    link_to 'Edit', edit_project_path(project), class: 'btn btn-primary' if policy(project).edit?
  end

  def project_delete_button(project)
    return unless policy(project).destroy?

    link_to 'Destroy',
            project_path(project),
            method: :delete,
            data: { confirm: 'Are you sure?' },
            class: 'btn btn-danger'
  end

  def project_create_button(project)
    link_to 'Create New project', new_project_path, class: 'btn btn-info' if policy(project).new?
  end

  def project_back_button
    link_to 'Back', projects_path, class: 'btn btn-info'
  end
end
