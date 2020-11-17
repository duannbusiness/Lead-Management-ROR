# frozen_string_literal: true

class CreatePhases < ActiveRecord::Migration[5.2]
  def change
    create_table :phases do |t|
      t.string :name, null: false
      t.references :lead, null: false
      t.references :user
      t.text :description, null: false
      t.string :phaseType, null: false
      t.boolean :status, default: false
      t.timestamp :start_date, null: false
      t.timestamp :due_date, null: false
      t.timestamps
    end
  end
end
