class User < ApplicationRecord
    # Relationships
    has_many :locations 



    validates :username, presence: true
    validates :type_of_user, presence: true
    validate :role_validation
    validates :location, presence: true
    validates :city, presence: true


    # owner functionality call be action
    # if owener check in views
    def owner_action(two_wheeler_capacity: nil, four_wheeler_capacity: nil, commercial_vehicle_capacity: nil)
        @user = User.find(params[:id])
        # will create location and rates
        locations.create(
            location_name: @user.location,
            two_wheeler_capacity: two_wheeler_capacity,
            four_wheeler_capacity: four_wheeler_capacity,
            commercial_vehicle_capacity: commercial_vehicle_capacity
        )
    end

    

    private

    def role_validation
        roles = ['owner', 'operator']
        errors.add('Type of User can only be', roles.join(', ')) unless roles.include? type_of_user
    end

end
