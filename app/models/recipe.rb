class Recipe < ApplicationRecord
    mount_uploader :image,  RecipeImageUploader
    has_many :ingredients,  dependent: :destroy
    accepts_nested_attributes_for :ingredients, allow_destroy: true,  reject_if: lambda { |attributes| attributes['name'].blank? }
end
