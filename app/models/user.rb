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

    private

    def role_validation
        roles = ['owner', 'operator']
        errors.add('Type of User can only be', roles.join(', ')) unless roles.include? type_of_user
    end

end
