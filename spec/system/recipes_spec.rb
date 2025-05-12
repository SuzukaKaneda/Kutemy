require 'rails_helper'

RSpec.describe "Recipes", type: :system do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe) }
    describe 'ログイン前' do
      describe 'ページ遷移確認' do
        context 'レシピの新規投稿ページにアクセス' do
          it 'アクセス失敗' do
            visit new_recipe_path
            expect(page).to have_content('ログインもしくはアカウント登録してください。')
            expect(current_path).to eq new_user_session_path
          end
        end
      end
    end
end
