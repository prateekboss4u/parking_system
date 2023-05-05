class Rate < ApplicationRecord
    belongs_to :location
    has_many :subscriptions

    validates :hourly_rate, presence: true, numericality: {greater_than:0}
    validates :daily_pass, presence: true, numericality: {greater_than:0}
    validates :weekly_pass, presence: true, numericality: {greater_than:0}
    validates :monthly_pass, presence: true, numericality: {greater_than:0}


    def operator_action(name:nil, type_of_pass:nil, plate_number: nil, start_date: nil, end_date: nil)
        # will create location and rates
        subscriptions.create(
            name: name,
            type_of_pass: type_of_pass,
            plate_number: plate_number,
            start_date: start_date,
            end_date: end_date
        )
    end


 
end
