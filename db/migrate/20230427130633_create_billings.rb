class CreateBillings < ActiveRecord::Migration[7.0]
  def change
    create_table :billings do |t|
      t.string :customer_name,  null: false
      t.float :amount, null: false
      t.string :duration, null: false
      t.string :plate_number, null: false

      t.timestamps
    end
  end
end
