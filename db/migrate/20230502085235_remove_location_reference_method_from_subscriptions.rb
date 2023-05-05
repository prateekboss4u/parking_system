class RemoveLocationReferenceMethodFromSubscriptions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :subscriptions, :location, null: false, foreign_key: true
  end
end
