class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new]
  before_action :author_gossip, only: [:edit, :update, :destroy]

  def index
    # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
    @gossips = Gossip.all
  end

  def show
    # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
    @gossip = Gossip.find(params[:id])
    @user = @gossip.user
    @like = Like.new
  end

  def new
    # Méthode qui crée un potin vide et l'envoie une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
    @gossip = Gossip.new
    #@user_id = session[:user_id]
  end

  def create
    # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
    @gossip = Gossip.new('title' => params[:title], 
                         'content' => params[:content])
    #@gossip.user = current_user
    @gossip.user = User.find_by(id: session[:user_id])

    if @gossip.save # essaie de sauvegarder en base @gossip
      flash[:success] = "Your gossip is saved"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
    @gossip = Gossip.find(params[:id])
  end

  def update
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    @gossip = Gossip.find(params[:id])
    gossip_params = params.permit(:title, :content)

      if @gossip.update(gossip_params)
        redirect_to @gossip
        flash[:success] = "Gossip updated !"
      else
        render :edit
      end
  end

  def destroy
    # Méthode qui récupère le potin concerné et le détruit en bas
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to @gossip
  end

  private

  def authenticate_user
    unless current_user
        flash[:danger] = "Please log in to continue"
        redirect_to new_session_path
    end
  end

  def author_gossip
    @gossip = Gossip.find(params[:id])
    unless current_user == @gossip.user 
        flash[:danger] = "You are not the author of this gossip"
        redirect_to root_path
    end
  end
end