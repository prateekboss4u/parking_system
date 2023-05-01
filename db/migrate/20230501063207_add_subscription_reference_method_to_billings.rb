class AddSubscriptionReferenceMethodToBillings < ActiveRecord::Migration[7.0]
  def change
    add_reference :billings, :subscription, null: false, foreign_key: true
  end
end
