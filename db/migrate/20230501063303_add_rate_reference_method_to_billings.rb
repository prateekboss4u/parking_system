class AddRateReferenceMethodToBillings < ActiveRecord::Migration[7.0]
  def change
    add_reference :billings, :rate, null: false, foreign_key: true
  end
end
