class CollaboratorsController < ApplicationController

  def create

     @collaborator = Collaborator.new(params.require(:collaborator).permit(:user_id, :wiki_id))
     

     
     if @collaborator.save
       flash[:notice] = "Collaborator was saved."
       redirect_to @collaborator.wiki
     else
       flash[:error] = "There was an error saving the collaborator. Please try again."
       redirect_to @collaborator.wiki
     end
  end

  def destroy
     @collaborator = Collaborator.find(params[:id])
     if @collaborator.destroy
       flash[:notice] = "#{@collaborator.id}was deleted successfully."
     else
       flash[:error] = "There was an error deleting the wiki."
     end

     redirect_to wikis_path
   end
end

