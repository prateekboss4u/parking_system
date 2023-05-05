class RemoveRateReferenceMethodFromBillings < ActiveRecord::Migration[7.0]
  def change
    remove_reference :billings, :rate, null: false, foreign_key: true
  end
end
