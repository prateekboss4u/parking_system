class RatesController < ApplicationController
  before_action :set_rate, only: %i[ show update destroy operator_action ]

  # GET /rates
  # GET /rates.json
  def index
    @rates = Rate.all
  end

  # GET /rates/1
  # GET /rates/1.json
  def show
  end

  # POST /rates
  # POST /rates.json
  def create
    @rate = Rate.new(rate_params)

    if @rate.save
      render :show, status: :created, location: @rate
    else
      render json: @rate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rates/1
  # PATCH/PUT /rates/1.json
  def update
    if @rate.update(rate_params)
      render :show, status: :ok, location: @rate
    else
      render json: @rate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rates/1
  # DELETE /rates/1.json
  def destroy
    @rate.destroy
  end
  
  def operator_action
    @subscription = @rate.operator_action(name: operator_action_params[:name],
                                              type_of_pass: operator_action_params[:type_of_pass], 
                                              plate_number: operator_action_params[:plate_number], 
                                              start_date: operator_action_params[:start_date], 
                                              end_date: operator_action_params[:end_date])
    if @subscription.errors.blank?
      render :subscription, status: :created
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = Rate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rate_params
      params.require(:rate).permit(:hourly_rate, :daily_pass, :weekly_pass, :monthly_pass)
    end

    def operator_action_params
      params.permit(:name, :type_of_pass, :plate_number, :start_date, :end_date)
    end
end
