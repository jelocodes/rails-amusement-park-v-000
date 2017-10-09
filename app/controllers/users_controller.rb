class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    @attraction = Attraction.find(params[:ride][:attraction_id])
    case params[:ride][:take_ride]
    when /tickets.*tall/
      flash[:notice] = "You are not tall enough to ride the #{@attraction.name} You do not have enough tickets to ride the #{@attraction.name}"
    when /tall/
      flash[:notice] = "You are not tall enough to ride the #{@attraction.name}"
    when /tickets/
      flash[:notice] = "You do not have enough tickets to ride the #{@attraction.name}"
    else
      flash[:notice] = "Thanks for riding the #{@attraction.name}!"
    end
    redirect_to user_path(@user)
  end

  def show
    if session.include? :user_id
      @user = User.find(params[:id])
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :height, :happiness, :nausea, :tickets, :admin)
  end

end
