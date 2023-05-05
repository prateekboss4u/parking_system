class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show update destroy owner_action ]

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
  #Show all the Billing
  def statement
    @location = Location.find_by(location_name: statement_params[:location_name])
    
    if @location
      @statement = @location.fetch_statement()
      if @statement[:status]
        render :statement, status: :ok
      else
        render json: 'No entry in the subscription book', status: :unprocessable_entity
      end
    else
      render json: 'Valid Location was not found!', status: :unprocessable_entity
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
    
    def owner_action_params
      parems.permit(:hourly_rate, :daily_pass, :weekly_pass, :monthly_pass)
    end

    def statement_params
      params.permit(:location_name)
    end
end
