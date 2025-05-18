require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  fixtures :users
  def setup
    @user2 = users(:two) # ユーザーのフィクスチャを使う場合
    sign_in @user2
    @recipe1 = recipes(:one)
    @recipe2 = recipes(:two)
  end

  test "should create favorite" do
    assert_difference('Favorite.count', 1) do
      post favorites_path, params: { recipe_id: @recipe2.id }
    end
  end

  test "should destroy favorite" do
    assert_difference('Favorite.count', -1) do
      favorite = favorites(:one)  # テストデータから特定のFavoriteを取得
      delete favorite_path(favorite)  # 正しいIDを渡して削除リクエストを送る
    end
  end
end
