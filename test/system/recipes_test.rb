require "application_system_test_case"

class RecipesTest < ApplicationSystemTestCase
  fixtures :users
  setup do
    @user = users(:one)
    sign_in @user
    @recipe = recipes(:one)
  end

  test "visiting the index" do
    visit recipes_url
    assert_text "ヒットしたレシピ"
  end

  test "should create recipe" do
    visit recipes_url
    find(".post").click
    find(".post").click
    find("input.title", visible: true).set(@recipe.title)
    find("input.point", visible: true).set(@recipe.get_point)
    click_button "投稿"
    assert_text "レシピを作成しました。"
  end

  test "should update Recipe" do
    visit recipe_url(@recipe)
    click_on "編集"
    find("input.title", visible: true).set(@recipe.title)
    find("input.point", visible: true).set(@recipe.get_point)
    click_on "投稿"
    assert_text "レシピの更新に成功しました。", wait: 15
  end

  test "should destroy Recipe" do
    visit recipe_url(@recipe)
    click_on "削除", match: :first
    page.accept_alert "本当に削除しますか？" do
    end
    assert_text "レシピの削除に成功しました。"
  end
end
