class CreatePhases < ActiveRecord::Migration[5.2]
  def change
    create_table :phases do |t|
      t.string :name
      t.references :lead
      t.references :user
      t.text :description
      t.string :type
      t.boolean :status
      t.timestamp :start_date
      t.timestamp :due_date
      t.timestamps
    end
  end
end
