class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :phase
      t.references :user
      t.string :status, default: 'Pending'
      t.text :description
      t.timestamps
    end
  end
end
