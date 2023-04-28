class User < ApplicationRecord
    validates :username, presence: true
    validates :type_of_user, presence: true
    validate :role_validation
    validates :location, presence: true
    validates :city, presence: true


    private

    def role_validation
        roles = ['owner', 'operator']
        errors.add('Type of User can only be', roles.join(', ')) unless roles.include? type_of_user
    end

end
