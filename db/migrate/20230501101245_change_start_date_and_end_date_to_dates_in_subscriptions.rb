class ChangeStartDateAndEndDateToDatesInSubscriptions < ActiveRecord::Migration[7.0]
  def change
    change_column :subscriptions, :start_date, :date
    change_column :subscriptions, :end_date, :date
  end
end
