class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show update destroy owner_action operator_action]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    if @location.save
      render :show, status: :created, location: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    if @location.update(location_params)
      render :show, status: :ok, location: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
  end

  def operator_action
    @subscription = @location.operator_action(name: operator_action_params[:name],
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
  def owner_action
    @rate = @location.owner_action(hourly_rate: owner_action_params[:hourly_rate],
                                    daily_pass: owner_action_params[:daily_pass],
                                    weekly_pass: owner_action_params[:weekly_pass],
                                    monthly_pass: owner_action_params[:monthly_pass])
                                    
    if @location.type_of_user == 'operator'
      redirect_to @location, alert: "Cannot create rates for operator-owned locations."
    end
    if @rate.errors.blank?
      render :rate, status: :created
    else
      render json: @rate.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:location_name, :two_wheeler_capacity, :four_wheeler_capacity, :commercial_vehicle_capacity)
    end

    def operator_action_params
      params.permit(:name, :type_of_pass, :plate_number, :start_date, :end_date)
    end
    
    def owner_action_params
      parems.permit(:hourly_rate, :daily_pass, :weekly_pass, :monthly_pass)
    end
end
