# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :phase, null: false
      t.references :user, null: false
      t.string :status, null: false, default: 'Pending'
      t.text :description, null: false
      t.timestamps
    end
  end
end
