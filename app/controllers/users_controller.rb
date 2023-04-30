class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
  end


  #Assigning Roles as owner or opearator
  def assign_role
    @user = User.find(params[:id])

    if @user.type_of_user == 'owner'
      owner_action
    else
      operator_action
    end

  end

  def owner_action
    @location = @user.owner_action(location_name: owner_action_params[:location_name], 
                                   two_wheeler_capacity: owner_action_params[:two_wheeler_capacity], four_wheeler_capacity: owner_action_params[:four_wheeler_capacity], commercial_vehicle_capacity: owner_action_param[:commercial_vehicle_capacity])
    if @location.errors.blank?
      render :location, status: :created
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  def operator_action
    @subscription = @user.operator_action(name: operator_action_params[:name], 
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
    def set_user
      @user = User.find(params[:id])
    end

    # Parameters for location
    def owner_action_params
      params.permit(:location_name, :two_wheeler_capacity, :four_wheeler_capacity, :commercial_vehicle_capacity)
    end

    def operator_action_params
      params.permit(:name, :type_of_pass, :plate_number, :start_date, :end_date)
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :type_of_user, :location, :city)
    end
end
