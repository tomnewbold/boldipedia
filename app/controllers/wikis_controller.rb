class WikisController < ApplicationController
  before_action :authenticate_user!, only: :index
  def index
    Wiki.visible_to(current_user)
    @wikis = policy_scope(Wiki)
    
  end



  def show
    @wiki = Wiki.find(params[:id])
    
    
  end

  def new
    @wiki = Wiki.new
  end

 

  def create
     @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :private))
     authorize @wiki

     @wiki.user_id = current_user.id
     if @wiki.save
       flash[:notice] = "Wiki was saved."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :new
     end
   end

  def edit
    @wiki = Wiki.find(params[:id])
  end

   def destroy
     @wiki = Wiki.find(params[:id])
     authorize @wiki
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to @wiki
     else
       flash[:error] = "There was an error deleting the post."
       render :new
     end
   end

  def update
     @wiki = Wiki.find(params[:id])
     if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end
end
