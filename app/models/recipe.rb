class Recipe < ApplicationRecord
  mount_uploader :image,  RecipeImageUploader

  belongs_to :user

  has_many :ingredients,  dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true,  reject_if: lambda { |attributes| attributes["name"].blank? }
  has_many :instructions,  dependent: :destroy
  accepts_nested_attributes_for :instructions, allow_destroy: true,  reject_if: lambda { |attributes| attributes["content"].blank? }

  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags
end
