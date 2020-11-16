class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :leads, :test_type, :leadType
    rename_column :phases, :type, :phaseType
  end
end
