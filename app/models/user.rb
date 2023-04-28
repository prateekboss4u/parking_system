class User < ApplicationRecord
    validates :username, presence: true
    validates :type_of_user, presence: true
    validate :role_validation
    validates :location, presence: true
    validates :city, presence: true


    # owner functionality call be action
    # if owener check in views
    def owner_action
        @user = User.find(params[:id])
        # will create location and rates

    end

    # operator functionality call be action
    def operator_action
        @user = User.find(params[:id])
        #will create  subscriptions

    end


    private

    def role_validation
        roles = ['owner', 'operator']
        errors.add('Type of User can only be', roles.join(', ')) unless roles.include? type_of_user
    end

end
