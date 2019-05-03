class LikesController < ApplicationController
      before_action :authenticate_user, only: [:new, :create, :destroy]
      before_action :find_gossip
      before_action :find_like, only: [:destroy]

  def new
  end

  def create
    if already_liked?
        flash[:notice] = "You can't like more than once"
    else
      @like = Like.create(user: current_user.id, gossip: params[:gossip_id])
      flash[:notice] = "You liked this gossip!"
    end
    redirect_to gossip_path(params[:gossip_id])

  end

  def destroy
    if !(already_liked?)
        flash[:notice] = "Cannot unlike"
      else
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

  def find_gossip
      @gossip = Gossip.find(params[:gossip_id])
  end

  def find_like
     @like = @gossip.likes.find(params[:id])
  end

end