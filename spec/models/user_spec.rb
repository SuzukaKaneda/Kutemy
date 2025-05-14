require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    context 'ユーザーが作成された時' do
      it '設定したすべてのバリデーションが機能しているか' do
        user = User.create(name: "name1", email: "user@example.com", password: "password")
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
      it 'emailがない場合にバリデーションが機能してinvalidになるか' do
        user = User.create(name: "name1", email: nil, password: "password")
        expect(user).to be_invalid
      end
      it 'emailが被った場合にバリデーションが機能してinvalidになるか' do
        user = create(:user)
        user2 = build(:user, email: user.email)
        expect(user2).to be_invalid
      end
      it 'passwordがない場合にバリデーションが機能してinvalidになるか' do
        user = User.create(name: "name1", email: "user@example.com", password: nil)
        expect(user).to be_invalid
      end
      it 'passwordが6文字以下の場合にバリデーションが機能してinvalidになるか' do
        user = build(:user, password: "abc")
        expect(user).to be_invalid
      end
    end
  end
end
