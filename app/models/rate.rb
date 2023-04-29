class Rate < ApplicationRecord
    belongs_to :user

    validates :hourly_rate, presence: true, numericality: {greater_than:0}
    validates :daily_pass, presence: true, numericality: {greater_than:0}
    validates :weekly_pass, presence: true, numericality: {greater_than:0}
    validates :monthly_pass, presence: true, numericality: {greater_than:0}

 
end
