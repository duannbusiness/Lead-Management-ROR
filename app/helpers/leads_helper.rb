# frozen_string_literal: true

module LeadsHelper
  def lead_edit_button(lead)
    link_to 'Edit', edit_lead_path(lead), class: 'btn btn-primary' if policy(lead).edit?
  end

  def lead_delete_button(lead)
    if policy(lead).destroy?
      link_to 'Destroy',
              lead_path(lead),
              method: :delete,
              data: { confirm: 'Are you sure?' },
              class: 'btn btn-danger'
    end
  end

  def lead_create_button(lead)
    link_to 'Create New Lead', new_lead_path, class: 'btn btn-info' if policy(lead).new?
  end

  def lead_status_change_button(lead)
    link_to 'Change Status', lead_status_path(lead), class: 'btn btn-primary' if policy(lead).status?
  end

  def lead_back_button
    link_to 'Back', leads_path, class: 'btn btn-info'
  end
end
