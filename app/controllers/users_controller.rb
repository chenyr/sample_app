class UsersController < ApplicationController
  before_filter :authenticate,  :except  => [:show, :new, :create]
  before_filter :correct_user,  :only  => [:edit, :update]
  before_filter :admin_user,    :only  => :destroy
  before_filter :non_signedin_actions, :only  => [:new, :create] 
  
  def new
    @title = "Sign up"
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to Info Hub"
      sign_in @user
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user" 
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end 
  end
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def destroy
    user = User.find(params[:id])
    if user.email != current_user.email 
      user.destroy
      flash[:success] = "User #{user.name} destroyed."
    else
      flash[:error] = "Can't destroy the admin users themselves"
    end
    redirect_to users_path
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    def non_signedin_actions
      redirect_to(root_path) unless current_user.nil?
    end
end
