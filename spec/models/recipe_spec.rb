require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'バリデーションチェック' do
    context 'レシピが作成された時' do
      it '設定したすべてのバリデーションが機能しているか' do
        user = User.create(name: "name1", email: "user@example.com", encrypted_password: "password")
        recipe = user.recipes.new(title: "aaa", get_point: "2")
        expect(recipe).to be_valid
        expect(recipe.errors).to be_empty
      end
      it 'titleがない場合にバリデーションが機能してinvalidになるか' do
        user = User.create(name: "name1", email: "user@example.com", encrypted_password: "password")
        recipe = user.recipes.new(title: nil, get_point: "2")
        expect(recipe).to be_invalid
      end
      it 'get_pointがない場合にバリデーションが機能してinvalidになるか' do
        user = User.create(name: "name1", email: "user@example.com", encrypted_password: "password")
        recipe = user.recipes.new(title: "aaa", get_point: nil)
        expect(recipe).to be_invalid
      end
    end
  end
end
