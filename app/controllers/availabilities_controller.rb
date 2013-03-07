class AvailabilitiesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @availabilities = @user.availabilities
    render json: @availabilities
  end

  def create
    start_t = params[:start]
    end_t = params[:end]
    @availability = Availability.new(
      start_t: start_t,
      end_t: end_t,
      user: current_user
    )
    if @availability.save
      format.json { render json: @availability, status: :created }
    else
      format.json { render json: @match.errors, status: :unprocessable_entity }
    end
  end

  def update
    @a = Availability.find(params[:id])
    @a.update_attributes(params)
    render json: @a
  end

  def delete
    @a = Availability.find(params[:id])
    @a.delete
    render json: @a
  end
end
