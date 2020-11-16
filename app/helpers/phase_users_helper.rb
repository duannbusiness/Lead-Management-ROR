# frozen_string_literal: true

module PhaseUsersHelper
  def phase_user_delete_button(phase, engineer)
    if phase_user_policy.destroy?
      link_to 'Remove',
              phase_phase_user_path(phase.id, engineer.id),
              method: :delete,
              data: { confirm: 'Are you sure?' },
              class: 'btn btn-danger'
    end
  end

  def phase_user_create_button(phase)
    link_to 'Add Engineer', new_phase_phase_user_path, class: 'btn btn-info' if phase_user_policy(phase).create?
  end

  private

  def phase_user_policy(phase)
    PhaseUserPolicy.new(current_user, phase)
  end
end
