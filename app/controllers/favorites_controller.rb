class FavoritesController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    current_user.favorite(@recipe)
    redirect_to recipes_path, notice: "いいねレシピに登録しました。"
  end

  def destroy
    @recipe = current_user.favorites.find(params[:id]).recipe
    current_user.unfavorite(@recipe)
    redirect_to recipes_path, notice: "いいねレシピから削除しました。", status: :see_other
  end
end
