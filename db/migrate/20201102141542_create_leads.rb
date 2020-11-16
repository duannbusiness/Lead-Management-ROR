class CreateLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :leads do |t|
      t.string :name
      t.references :user
      t.string :client_name
      t.string :client_email
      t.string :client_contact
      t.string :client_address
      t.timestamp :transition_date
      t.string :test_type
      t.boolean :is_sale
      t.timestamps
    end
  end
end
