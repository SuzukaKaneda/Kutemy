class Recipe < ApplicationRecord
    mount_uploader :image,  RecipeImageUploader
    has_many :ingredients,  dependent: :destroy
    accepts_nested_attributes_for :ingredients
end
