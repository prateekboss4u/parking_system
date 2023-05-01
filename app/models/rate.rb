class Rate < ApplicationRecord
    belongs_to :user

    validates :hourly_rate, presence: true, numericality: {greater_than:0}
    validates :daily_pass, presence: true, numericality: {greater_than:0}
    validates :weekly_pass, presence: true, numericality: {greater_than:0}
    validates :monthly_pass, presence: true, numericality: {greater_than:0}

    #Regular Method
    def calculate_cost(duration_in_hours)
        case name
        when 'Hourly'
            hourly_rate * duration_in_hours
        when 'Daily'
            daily_rate * (duration_in_hours / 24.0).ceil
        when 'Weekly'
            weekly_rate * (duration_in_hours / 168.0).ceil
        when 'Monthly'
            monthly_rate * (duration_in_hours / 720.0).ceil
        end
    end
end
