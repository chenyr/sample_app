class RelationshipsController < ApplicationController
  
  before_filter :authenticate
  
  def create
    followed = User.find(params[:relationship][:followed_id])
    current_user.follow!(followed)
    redirect_to followed
  end
  
  def destroy
    followed = Relationship.find(params[:id]).followed
    current_user.unfollow!(followed)
    redirect_to followed
  end
  
end