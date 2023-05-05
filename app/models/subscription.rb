class Subscription < ApplicationRecord
    belongs_to :rate
    has_many :billings

    after_create :bill_calculation
    
    
    validates :name, presence: true, exclusion: { in: %w(owner operator) }
    validates :type_of_pass, presence: true, inclusion: { in: %w(monthly weekly daily none) }
    validates :plate_number, presence: true, uniqueness: true
    validates :start_date,   presence: true  
    validates :end_date, presence: true
    validate  :end_date_after_start_date



    def calculate_billing_amount(customer_name:name, amount: 0, duration:0, number_plate:plate_number)
        
        billings.create(subscription_id: id,
                        customer_name: customer_name,
                        amount: amount,
                        duration: duration,
                        plate_number: number_plate
                        )
    end

    def bill_calculation
        start_time = DateTime.parse(start_date.to_s)
        end_time = DateTime.parse(end_date.to_s)
        duration = ((end_time - start_time) * 24).ceil.to_i

        hourly_rate = rate.hourly_rate
        daily_rate = rate.daily_pass
        weekly_rate = rate.weekly_pass
        monthly_rate = rate.monthly_pass

        total_cost = 0
        if type_of_pass == 'none'
            total_cost += (duration * hourly_rate)
        elsif type_of_pass == 'daily'
            reamining_time = (duration - 24)
            if reamining_time <= 0
                total_cost += daily_rate
            else
                total_cost += ((reamining_time*hourly_rate) + daily_rate)
            end
        elsif type_of_pass == 'weekly'
            reamining_time = (duration - (24*7))
            if reamining_time <= 0
                total_cost += weekly_rate
            else
                total_cost += ((reamining_time*hourly_rate) + weekly_rate)
            end
        elsif type_of_pass == 'monthly'  
            reamining_time = (duration - (24*7*4))
            if reamining_time <= 0
                total_cost += monthly_rate
            else
                total_cost += ((reamining_time*hourly_rate) + monthly_rate)
            end
        end

        calculate_billing_amount(amount: total_cost, duration: duration)
    end

    def fetch_receipt
        errors = []

        return { status: false, transactions: nil, errors: errors } unless errors.blank?

        return { status: true, transactions: billings.to_a, errors: nil }
    end


    private
    # Custome Validation
    # create validation for start date always be before than end date
    # create validation for end date is greter than start date
    def end_date_after_start_date
        return if start_date.blank? || end_date.blank?
    
        errors.add(:end_date, "must be after the start date") if end_date < start_date
    end

    def is_owner
      if user.type_of_user == 'owner'
          errors.add("Owners are not made to do operators work")
      end
    end
end
