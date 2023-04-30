class Subscription < ApplicationRecord
    belongs_to :location
    
    validates :name, presence: true, exclusion: { in: %w(owner operator) }
    validates :type_of_pass, presence: true, inclusion: { in: %w(monthly weekly daily none) }
    validates :plate_number, presence: true, uniqueness: true
    validates :start_date,   presence: true  
    validates :end_date, presence: true
    validate  :end_date_after_start_date


    private
    # Custome Validation
    # create validation for start date always be before than end date
    # create validation for end date is greter than start date
    def end_date_after_start_date
        return if start_date.blank? || end_date.blank?
    
        errors.add(:end_date, "must be after the start date") if end_date < start_date
      end
end
