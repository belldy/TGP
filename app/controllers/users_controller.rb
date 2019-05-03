class UsersController < ApplicationController
  
  def index
    @users = User.All
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new('first_name' => params[:first_name],
    	             'last_name' => params[:last_name],
    	             'description' => params[:description],
    	             'email' => params[:email],
    	             'age' => params[:age],
    	             'password' => params[:password],
    	             'password_confirmation' => params[:password_confirmation],
    	             'city_id' => City.all.sample.id)
    if @user.save 
      redirect_to root_path
      flash[:success] = "Yay! Welcome!"
    else
      render 'new'
    end
  end 


end


   