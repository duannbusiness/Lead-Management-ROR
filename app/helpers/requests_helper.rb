# frozen_string_literal: true

module RequestsHelper
  def phase_manager_delete_button(phase, request)
    return unless request_policy(phase).destroy?

    link_to 'Remove ', phase_request_path(phase.id, request.id),
            method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-danger'
  end

  def phase_manager_create_button(phase)
    link_to 'Add Manager', new_phase_request_path, class: 'btn btn-info' if request_policy(phase).create?
  end

  def request_policy(phase)
    RequestPolicy.new(current_user, phase)
  end
end
