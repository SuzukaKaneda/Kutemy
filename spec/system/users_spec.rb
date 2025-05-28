require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  describe 'ログイン動作確認' do
    context '全て正しく入力した時' do
      it 'ログイン成功' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        find('.manual_login').click
        expect(page).to have_content('ログインしました。')
      end
    end
    context '全て正しく入力した時' do
      it 'ログイン成功' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        find('.manual_login').click
        expect(page).to have_content('ログインしました。')
      end
    end
    context 'メールアドレスが空欄時' do
      it 'ログイン失敗' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: nil
        fill_in 'パスワード', with: user.password
        find('.manual_login').click
        expect(page).to have_content('メールアドレスまたはパスワードが違います。')
      end
    end
    context 'パスワードが空欄時' do
      it 'ログイン失敗' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: nil
        find('.manual_login').click
        expect(page).to have_content('メールアドレスまたはパスワードが違います。')
      end
    end
  end
  describe 'サインイン動作確認' do
    context 'メールアドレスが被っている時' do
      it '登録失敗' do
        visit new_user_registration_path
        fill_in 'アカウント名', with: user.name
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        fill_in 'パスワード（確認用）', with: user.password
        find('.manual_signin').click
        expect(page).to have_content('は既に使用されています。')
      end
    end
    context 'パスワードが確認用と一致しない時' do
      it '登録失敗' do
        user2 = User.build(name: "name10", email: "test_10@example.com", password: "password10")
        visit new_user_registration_path
        fill_in 'アカウント名', with: user.name
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user2.password
        fill_in 'パスワード（確認用）', with: user.password
        find('.manual_signin').click
        expect(page).to have_content('パスワード（確認用） 「パスワード」と「パスワード確認」が一致しません。')
      end
    end
    context 'パスワードが短すぎる時' do
      it '登録失敗' do
        user2 = User.build(name: "name10", email: "test_10@example.com", password: "pass")
        visit new_user_registration_path
        fill_in 'アカウント名', with: user2.name
        fill_in 'メールアドレス', with: user2.email
        fill_in 'パスワード', with: user2.password
        fill_in 'パスワード（確認用）', with: user2.password
        find('.manual_signin').click
        expect(page).to have_content('パスワード は6文字以上に設定して下さい。')
      end
    end
    context '正しく入力できている時' do
      it '登録成功' do
        user2 = User.build(name: "name10", email: "test_10@example.com", password: "password10")
        visit new_user_registration_path
        fill_in 'アカウント名', with: user2.name
        fill_in 'メールアドレス', with: user2.email
        fill_in 'パスワード（6文字以上）', with: user2.password
        fill_in 'パスワード（確認用）', with: user2.password
        find('.manual_signin').click
        expect(page).to have_content('アカウント登録をしました。')
      end
    end
  end
  describe 'ご褒美目標達成時ページ遷移' do
    context 'ユーザーのポイント数が目標のポイント数を上回った時' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        find('.manual_login').click
        @reward = user.rewards.create(required_points: "2", content: "お菓子を買う", completed: false)
      end
      it 'モーダル出現' do
        find('.card').click
        find('input.add_points', visible: true).set(3)
        click_on '加算'
        expect(page).to have_content('目標ポイントを達成しました。')
      end
    end
  end
  describe 'ログアウト動作確認' do
    context 'ログイン状態でログアウトボタンを押す' do
      it 'ログアウト成功' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        find('.manual_login').click
        find('.user_icon').hover
        click_on 'ログアウト'
        expect(page).to have_content('ログアウトしました。')
      end
    end
  end
end
