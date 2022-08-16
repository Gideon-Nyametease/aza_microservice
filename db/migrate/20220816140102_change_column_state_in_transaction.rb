class ChangeColumnStateInTransaction < ActiveRecord::Migration[6.1]
  def change
    change_column :transactions, :active_status, :boolean, default: true
  end
end
