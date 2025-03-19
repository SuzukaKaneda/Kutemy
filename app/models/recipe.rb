class Recipe < ApplicationRecord
    mount_uploader :image,  RecipeImageUploader
    has_many :ingredients,  dependent: :destroy
    accepts_nested_attributes_for :ingredients, allow_destroy: true,  reject_if: lambda { |attributes| attributes['name'].blank? }
    has_many :instructions,  dependent: :destroy
    accepts_nested_attributes_for :instructions, allow_destroy: true,  reject_if: lambda { |attributes| attributes['step'].blank? }
end
