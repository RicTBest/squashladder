class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :require_login

  def require_login
    unless logged_in?
      redirect_to '/welcome'
    end
  end

  def logged_in?
    !!current_user
  end

  def index
    @user = current_user
    @availabilities = @user.future_availabilities
    @matches = @user.matches
    @unconfirmed_matches = @matches.select { |m| m.confirmed? }
    @confirmed_matches = @matches.select { |m| !m.confirmed? }
    #@recent_matches = @confirmed_matches.limit(2)
    #@distant_matches = @confirmed_matches.offset(2)
    @nearby_ranks = @user.nearby_ranks
    @above_ranks = @user.above_ranks
    @below_ranks = @user.below_ranks
    @all_ranks = User.order("rank")
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
