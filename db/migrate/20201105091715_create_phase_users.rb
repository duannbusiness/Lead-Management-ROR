# frozen_string_literal: true

class CreatePhaseUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :phase_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :phase, null: false, foreign_key: true
      t.text :description, null: false
      t.string :status, null: false, default: 'pending'
      t.timestamps
    end
  end
end
