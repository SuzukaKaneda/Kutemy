class FavoritesController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    current_user.favorite(@recipe)
    @recipe.create_notification_favorite!(current_user)
  end

  def destroy
    @recipe = current_user.favorites.find(params[:id]).recipe
    current_user.unfavorite(@recipe)
  end
end
