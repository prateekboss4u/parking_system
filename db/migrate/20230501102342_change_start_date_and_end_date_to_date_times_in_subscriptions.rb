class ChangeStartDateAndEndDateToDateTimesInSubscriptions < ActiveRecord::Migration[7.0]
  def change
    change_column :subscriptions, :start_date, :datetime
    change_column :subscriptions, :end_date, :datetime
  end
end
