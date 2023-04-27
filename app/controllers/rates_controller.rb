class RatesController < ApplicationController
  before_action :set_rate, only: %i[ show update destroy ]

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = Rate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rate_params
      params.require(:rate).permit(:hourly_rate, :daily_pass, :weekly_pass, :monthly_pass)
    end
end
