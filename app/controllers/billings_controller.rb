class BillingsController < ApplicationController
  before_action :set_billing, only: %i[ show update destroy ]

  # GET /billings
  # GET /billings.json
  def index
    @billings = Billing.all
  end

  # GET /billings/1
  # GET /billings/1.json
  def show
  end

  # POST /billings
  # POST /billings.json
  def create
    @billing = Billing.new(billing_params)

    if @billing.save
      render :show, status: :created, location: @billing
    else
      render json: @billing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /billings/1
  # PATCH/PUT /billings/1.json
  def update
    if @billing.update(billing_params)
      render :show, status: :ok, location: @billing
    else
      render json: @billing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /billings/1
  # DELETE /billings/1.json
  def destroy
    @billing.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_billing
      @billing = Billing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def billing_params
      params.require(:billing).permit(:customer_name, :amount, :duration, :plate_number)
    end
end
