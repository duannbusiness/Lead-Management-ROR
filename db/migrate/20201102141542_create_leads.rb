# frozen_string_literal: true

class CreateLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :leads do |t|
      t.string :name, null: false
      t.references :user, null: false
      t.string :client_name, null: false
      t.string :client_email, null: false
      t.string :client_contact, null: false
      t.string :client_address, null: false
      t.timestamp :transition_date
      t.string :leadType, null: false
      t.boolean :is_sale, default: 0
      t.timestamps
    end
  end
end
