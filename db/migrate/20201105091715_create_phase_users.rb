class CreatePhaseUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :phase_users do |t|
      t.references :user
      t.references :phase
      t.text :description
      t.string :status, default: 'pending'
      t.timestamps
    end
  end
end
