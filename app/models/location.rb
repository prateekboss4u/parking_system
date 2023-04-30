class Location < ApplicationRecord
    # Relationships
    belongs_to :user
    has_many   :subscriptions

    validate :is_owner
    validates :location_name, presence: true
    validates :two_wheeler_capacity, numericality: { greater_than_or_equal_to: 0 }
    validates :four_wheeler_capacity, numericality: { greater_than_or_equal_to: 0 }
    validates :commercial_vehicle_capacity, numericality: { greater_than_or_equal_to: 0 }


    # operator functionality call be action
    def operator_action
        @user = User.find(params[:id])
        #will create  subscriptions
        subscriptions.create(
            name: name,
            type_of_pass: type_of_pass,
            plate_number: plate_number,
            start_date: start_date,
            end_date: end_date
        )
    end

    
    private

    def is_owner
        if user.type_of_user == 'operator'
            errors.add("Operators are not allowed to make location changes")
        end
    end
end
