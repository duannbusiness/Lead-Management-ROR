# frozen_string_literal: true

module PhasesHelper
  def edit_button(phase)
    link_to 'Edit', edit_lead_phase_path(phase.lead_id, phase.id), class: 'btn btn-primary' if policy(phase).edit?
  end

  def delete_button(phase)
    return unless policy(phase).destroy?

    link_to 'Destroy', lead_phase_path(phase.lead_id, phase.id),
            method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-danger'
  end

  def create_button(lead)
    link_to 'Create New Phase', new_lead_phase_path(lead.id), class: 'btn btn-info' if policy(lead).new?
  end

  def phase_status_change_button(phase)
    link_to 'Change Status', phase_status_path(phase), class: 'btn btn-primary' if policy(phase).status?
  end

  def phase_back_button(phase)
    link_to 'Back', lead_phases_path(phase.lead_id), class: 'btn btn-info'
  end
end
