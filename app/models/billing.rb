class Billing < ApplicationRecord
    belongs_to :subscription
    belongs_to :rates

    validates :customer_name, presence: true
    validates :amount, presence: true
    validates :duration, presence: true
    validates :plate_number, presence: true

end
