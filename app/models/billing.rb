class Billing < ApplicationRecord

    validates :customer_name, presence: true
    validates :amount, presence: true
    validates :duration, presence: true
    validates :plate_number, presence: true

end
