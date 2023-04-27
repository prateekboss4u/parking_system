class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :name, null: false
      t.string :type_of_pass, null: false
      t.string :plate_number, null: false
      t.string :start_date, null: false
      t.string :end_date, null: false

      t.timestamps
    end
  end
end
