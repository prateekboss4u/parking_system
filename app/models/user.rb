class User < ApplicationRecord
    # Relationships
    if :is_owner?
        has_many :locations 
    else
        has_many :subscriptions
    end


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

    def is_owner?
        type_of_user == 'owner'
    end

    def role_validation
        roles = ['owner', 'operator']
        errors.add('Type of User can only be', roles.join(', ')) unless roles.include? type_of_user
    end

end
