class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  has_many :recipes,  dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe
  has_many :rewards,  dependent: :destroy

  def favorite(recipe)
    favorite_recipes << recipe
  end
  
  def unfavorite(recipe)
    favorite_recipes.destroy(recipe)
  end
  
  def favorite?(recipe)
    favorite_recipes.include?(recipe)
  end
end
