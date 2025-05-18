require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  fixtures :users
  test "should create recipe for user" do
    user = users(:one)  # users.ymlで定義したoneを呼び出す
    # userがちゃんと呼び出せているか確認するために、以下のように使う
    assert_equal "Alice", user.name
  end

  setup do
    @user = users(:one) # ユーザーのフィクスチャを使う場合
    sign_in @user
    @recipe = recipes(:one)
  end

  test "should get index" do
    get recipes_url
    assert_response :success
  end

  test "should get new" do
    get new_recipe_url
    assert_response :success
  end

  test "should create recipe" do
    assert_difference("Recipe.count") do
      post recipes_url, params: { recipe: { title: @recipe.title, get_point: @recipe.get_point } }
    end

    assert_redirected_to recipe_url(Recipe.last)
  end

  test "should show recipe" do
    get recipe_url(@recipe)
    assert_response :success
  end

  test "should get edit" do
    get edit_recipe_url(@recipe)
    assert_response :success
  end

  test "should update recipe" do
    patch recipe_url(@recipe), params: { recipe: { title: @recipe.title } }
    assert_redirected_to recipe_url(@recipe)
  end

  test "should destroy recipe" do
    assert_difference("Recipe.count", -1) do
      delete recipe_url(@recipe)
    end

    assert_redirected_to recipes_url
  end
end
