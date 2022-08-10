class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :customer_id
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :phone_number
      t.boolean :active_status

      t.timestamps
    end
  end
end
