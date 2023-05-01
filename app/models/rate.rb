class Rate < ApplicationRecord
    belongs_to :user

    validates :hourly_rate, presence: true, numericality: {greater_than:0}
    validates :daily_pass, presence: true, numericality: {greater_than:0}
    validates :weekly_pass, presence: true, numericality: {greater_than:0}
    validates :monthly_pass, presence: true, numericality: {greater_than:0}

    #Regular Method
    def rate_for_duration(duration_in_minutes)
        if duration_in_minutes < 60 
            hourly_rate
        elsif duration_in_minutes < 24 * 60
            daily_pass
        elsif duration_in_minutes < 7 * 24 * 60
            weekly_pass
        else
            monthly_pass
        end
    end
end
