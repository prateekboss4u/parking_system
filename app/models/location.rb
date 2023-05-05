class Location < ApplicationRecord
    # Relationships
    belongs_to :user
    has_many :rates
    has_many :subscriptions, through: :rates

    validate :is_owner
    validates :location_name, presence: true, uniqueness: { scope: :location_name }
    validates :two_wheeler_capacity, numericality: { greater_than_or_equal_to: 0 }
    validates :four_wheeler_capacity, numericality: { greater_than_or_equal_to: 0 }
    validates :commercial_vehicle_capacity, numericality: { greater_than_or_equal_to: 0 }



    def check_user_type
        user.type_of_user == 'operator' ? operate_action() : owner_action()
    end
    # Subscription management for operateor user

    def owner_action(hourly_rate:nil, daily_pass:nil, weekly_pass: nil, monthly_pass:nil)
        rates.create(
            user_id: id,
            hourly_rate: hourly_rate,
            daily_pass: daily_pass,
            weekly_pass: weekly_pass,
            monthly_pass: monthly_pass,
        )
    end

    # Searching in Subscriptions
    def fetch_statement()

        return { status: true, transactions: subscriptions.all, errors: nil }

    end


    private

    def is_owner
        if user.type_of_user == 'operator'
            errors.add("Operators are not allowed to make location changes")
        end
    end

    
end
