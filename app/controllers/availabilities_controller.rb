class AvailabilitiesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @availabilities = @user.availabilities
    render json: @availabilities
  end

  def create
    # start_t = params[:start]
    # end_t = params[:end]
    # @availability = Availability.new(
    #   start_t: start_t,
    #   end_t: end_t,
    #   user: current_user
    # )
    
    @availability = Availability.new(params[:availability])
    if @availability.save
      flash[:success] = "New availability created!"
    else
      flash[:error] = @availability.errors[:start_t][0]
    end
    redirect_to "/"

    # if @availability.save
    #   format.json { render json: @availability, status: :created }
    # else
    #   format.json { render json: @match.errors, status: :unprocessable_entity }
    # end
  end

  def update
    @a = Availability.find(params[:id])
    @a.update_attributes(params)
    render json: @a
  end

  def destroy
    @a = Availability.find(params[:id])
    @a.destroy
    redirect_to "/"
  end
end
