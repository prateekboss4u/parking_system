class CreateRates < ActiveRecord::Migration[7.0]
  def change
    create_table :rates do |t|
      t.float :hourly_rate, null: false
      t.float :daily_pass, null: false
      t.float :weekly_pass, null: false
      t.float :monthly_pass, null: false

      t.timestamps
    end
  end
end
