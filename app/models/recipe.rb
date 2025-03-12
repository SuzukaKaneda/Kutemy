class Recipe < ApplicationRecord
    mount_uploader :image,  RecipeImageUploader
end
