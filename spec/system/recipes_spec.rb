require 'rails_helper'

RSpec.describe "Recipes", type: :system do
  let!(:user) { create(:user) }
  let!(:recipe) { create(:recipe) }
    describe 'ログイン前' do
      describe 'ページ遷移確認' do
        context 'レシピの新規投稿ページにアクセス' do
          it 'アクセス失敗' do
            visit new_recipe_path
            expect(page).to have_content('ログインもしくはアカウント登録してください。')
            expect(current_path).to eq new_user_session_path
          end
        end
        context 'レシピを探す' do
          it '一覧検索成功' do
            visit recipes_look_path
            click_on '検索'
            expect(page).not_to have_content('検索結果')
            expect(page).to have_content('ログイン')
          end
          it '詳細閲覧成功' do
            visit recipe_path(recipe)
            expect(page).to have_content('レシピ詳細')
            expect(page).to have_content(recipe.title)
          end
        end
      end
      describe '動作制限確認' do
        context 'レシピにいいねする' do
          it 'いいね失敗' do
            visit recipe_path(recipe)
            find('.heart_botton').click
            page.driver.browser.switch_to.alert.accept
            expect(page).to have_selector('.no_favorite')
          end
        end
        context 'レシピにコメントする' do
          it 'コメント失敗' do
            visit recipe_path(recipe)
            fill_in 'コメントを送ろう！', with: '美味しそう'
            click_on '投稿'
            page.driver.browser.switch_to.alert.accept
            expect(page).not_to have_content('美味しそう')
          end
        end
      end
    end
    describe 'ログイン後' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        find('.manual_login').click
      end
      describe '動作確認' do
        context 'ログイン確認' do
          it '成功確認' do
            expect(page).to have_content('いいねレシピ')
          end
        end
        context 'レシピの新規投稿をする' do
          it '新規作成成功' do
            click_on '投稿する'
            find('input.title', visible: true).set("料理名")
            find('input.point', visible: true).set(2)
            click_button '投稿'
            expect(page).to have_content('レシピを作成しました。', wait: 10)
          end
        end
        context 'レシピにいいねする' do
          it 'いいね成功' do
            click_on '検索'
            click_on recipe.title
            find('.heart_botton').click
            expect(page).not_to have_selector('.no_favorite')
          end
        end
        context 'レシピのコメントをする' do
          it 'コメント成功' do
            click_on '検索'
            click_on recipe.title
            fill_in 'コメントを送ろう！', with: '美味しそう'
            click_on '投稿'
            expect(page).to have_content('美味しそう')
            expect(page).to have_content('編集')
          end
        end
      end
    end
end
