class AddRateReferenceMethodToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_reference :subscriptions, :rate, foreign_key: true
  end
end
