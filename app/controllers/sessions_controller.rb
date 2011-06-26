class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end
  
  def create
    password = params[:session][:password]
    email = params[:session][:email]
    user = User.authenticate(email, password)
    if user.nil?
      flash.now[:error] = "Invalid email or password"
      @title = "Sign in"
      render 'new'
    else 
      sign_in user
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
