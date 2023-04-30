class Location < ApplicationRecord
    # Relationships
    belongs_to :user

    validate :is_owner
    validates :location_name, presence: true
    validates :two_wheeler_capacity, numericality: { greater_than_or_equal_to: 0 }
    validates :four_wheeler_capacity, numericality: { greater_than_or_equal_to: 0 }
    validates :commercial_vehicle_capacity, numericality: { greater_than_or_equal_to: 0 }


    private

    def is_owner
        if user.type_of_user == 'operator'
            errors.add("Operators are not allowed to make location changes")
        end
    end
end
