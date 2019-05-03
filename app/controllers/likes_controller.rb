class LikesController < ApplicationController
      before_action :authenticate_user, only: [:new, :create, :destroy]
     

  def new
  end

  def create
    @like = Like.create(user: current_user.id, gossip: params[:gossip_id])
    flash[:success] = "You liked this gossip!"
  end
    redirect_to gossip_path(params[:gossip_id])

  end

  def destroy
    @like.destroy
    flash[:danger] = "Disliked!"
  end
    redirect_to gossip_path(params[:gossip_id])
  end

  private

  def already_liked?
    Like.where(user: current_user.id, gossip: params[:gossip_id]).exists?
  end

  def authenticate_user
      unless current_user
        flash[:danger] = "Please log in to continue"
        redirect_to new_session_path
    end
  end

end