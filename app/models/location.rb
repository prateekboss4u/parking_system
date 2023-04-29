class Location < ApplicationRecord
    # Relationships
    belongs_to :user

    validates :location_name, presence: true
    validates :two_wheeler_capacity, numericality: { greater_than_or_equal_to: 0 }
    validates :four_wheeler_capacity, numericality: { greater_than_or_equal_to: 0 }
    validates :commercial_vehicle_capacity, numericality: { greater_than_or_equal_to: 0 }

end
