class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[ show update destroy calculate_billing_amount ]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    if @subscription.save
      render :show, status: :created, location: @subscription
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    if @subscription.update(subscription_params)
      render :show, status: :ok, location: @subscription
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
  end

  def calculate_billing_amount
    @billing = @subscription.calculate_billing_amount(customer_name: calculate_billing_amount_params[:customer_name],
                                              amount: calculate_billing_amount_params[:amount],
                                              duration: calculate_billing_amount_params[:duration],
                                              plate_number: calculate_billing_amount_params[:plate_number]
                                            )

    if @billing.errors.blank?
      render :billing, status: :created
    else
      render json: @billing.errors, status: :unprocessable_entity
    end
  end

  def receipt
    @subscription = Subscription.find_by(name: receipt_params[:name],
                                         plate_number: receipt_params[:plate_number])

    if @subscription
      @receipt = @subscription.fetch_receipt()
      
      if @receipt[:status]
        render :receipt, status: :ok
      else
        render json: @receipt[:errors], status: :unprocessable_entity
      end
    else
      render json: 'Valid Customer was not found!', status: :unprocessable_entity
    end

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.require(:subscription).permit(:name, :type_of_pass, :plate_number, :start_date, :end_date)
    end

    def calculate_billing_amount_params
      params.permit(:customer_name, :amount, :duration, :plate_number)
    end  
    
    def receipt_params
      params.permit(:name, :plate_number)
    end
end
