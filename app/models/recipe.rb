class Recipe < ApplicationRecord
  mount_uploader :image,  RecipeImageUploader

  belongs_to :user

  has_many :ingredients,  dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true,  reject_if: lambda { |attributes| attributes["name"].blank? }
  has_many :instructions,  dependent: :destroy
  accepts_nested_attributes_for :instructions, allow_destroy: true,  reject_if: lambda { |attributes| attributes["content"].blank? }

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  scope :with_tag, ->(tag_id) { joins(:recipe_tags).where(recipe_tags: { tag_id: tag_id }) }
  def self.ransackable_attributes(auth_object = nil)
    %w[title] # 検索可能な属性を指定
  end
end
