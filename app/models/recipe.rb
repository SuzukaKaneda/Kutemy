class Recipe < ApplicationRecord
    mount_uploader :image,  RecipeImageUploader
    has_many :ingredients
end
